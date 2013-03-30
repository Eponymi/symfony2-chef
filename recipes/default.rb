#
# Cookbook Name:: symfony2-chef
# Recipe:: default
#
# Copyright 2013, Robert Dolca
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

node.set['nodejs']['install_method'] = node['app']['node']['install_method']

include_recipe 'apt'
include_recipe 'htop'
include_recipe 'curl'
include_recipe 'mysql::client'
include_recipe 'nodejs'
include_recipe 'npm'
include_recipe 'git'
include_recipe 'java'
include_recipe 'php'
include_recipe 'composer'

if node['app']['database']['create']
  include_recipe 'mysql::client'
end

node[:app][:node][:packages].each do |package|
  npm_package package
end

application node[:app][:name] do
  path  node[:app][:path]
  owner node[:app][:user]
  group node[:app][:group]
  repository node[:app][:repository]
  deploy_key node[:app][:deploy_key]
  revision node[:app][:revision]
  packages node[:app][:packages]
  action node[:app][:force_deploy] ? :force_deploy : :deploy

  shared_vendor  = "#{node[:app][:path]}/shared/vendor"
  current_vendor = "#{node[:app][:path]}/current/vendor"
  
  before_deploy do

    # vendor folder is backed up in case of a redeploy of the same version
    # if there is an older vendor folder in shared folder it is deleted
    directory shared_vendor do
      recursive true
      action :delete
    end
    
    if File.directory? current_vendor
      bash "copy vendor to shared" do
        user node[:app][:user]
        group node[:app][:group]
        code "cp -R #{current_vendor} #{shared_vendor}"
      end
    end
    
  end
  
  before_symlink do
    path = @new_resource.release_path
    
    if node[:app][:database][:enckey_path]

      mysql_secret = Chef::EncryptedDataBagItem.load_secret(node[:app][:database][:enckey_path])
      mysql_creds = Chef::EncryptedDataBagItem.load("credential", "mysql", mysql_secret)
  
      node.set[:app][:database][:host] = mysql_creds['host']
      node.set[:app][:database][:port] = mysql_creds['port']
      node.set[:app][:database][:name] = mysql_creds['dbname']
      node.set[:app][:database][:user] = mysql_creds['user']
      node.set[:app][:database][:password] = mysql_creds['password']
    end
    
    if node[:app][:mailer][:enckey_path]

      smtp_secret = Chef::EncryptedDataBagItem.load_secret(node[:app][:mailer][:enckey_path])
      smtp_creds = Chef::EncryptedDataBagItem.load("credential", "smtp", smtp_secret)
  
      node.set[:app][:mailer][:host] = smtp_creds['host']
      node.set[:app][:mailer][:user] = smtp_creds['user']
      node.set[:app][:mailer][:password] = smtp_creds['password']
    end
    
    template "#{path}/web/.htaccess" do
      source "#{path}/web/htaccess.erb"
      local true
      mode 0644
      owner node[:app][:user]
      group node[:app][:group]
    end
    
    template "#{path}/app/config/parameters.yml" do
      source "#{path}/app/config/parameters.yml.erb"
      local true
      mode 0600
      owner node[:app][:user]
      group node[:app][:group]
    end

    
    if File.directory? shared_vendor
      
      bash "copy vendor from shared" do
        user node[:app][:user]
        group node[:app][:group]
        code "cp -R #{shared_vendor} #{path}/vendor"  
      end
      
      directory shared_vendor do
        recursive true
        action :delete
      end
      
    end

    composer_project path do
      action :install
      user node[:app][:user]
      group node[:app][:group]
    end

    node.set[:symfony2][:user]  = node[:app][:user]
    node.set[:symfony2][:group] = node[:app][:group]
    
    # Deletes hard copied bundles
    directory "#{path}/web/bundles" do
      recursive true
      action :delete
    end
    
    symfony2_console "assets:install" do
      action :cmd
      command "assets:install --symlink"
      path path
    end
    
    symfony2_console "assetic:dump" do
      action :cmd
      command "assetic:dump"
      path path
    end
    
    symfony2_console "cache:clear" do
      action :cmd
      command "cache:clear"
      path path
    end
    
    symfony2_console "cache:warmup" do
      action :cmd
      command "cache:warmup"
      path path
    end
    
    symfony2_console "doctrine:ensure-production-settings" do
      action :cmd
      command "doctrine:ensure-production-settings"
      path path
    end
    
    if node['app']['database']['create']
      
      if node['app']['database']['password'] != '~' and node['app']['database']['password'] != ''
        password = "-p#{node['app']['database']['password']}"
      end

      execute "doctrine:database:create" do
        action :run
        command "mysql -u #{node['app']['database']['user']} #{password} -e 'CREATE DATABASE IF NOT EXISTS #{node['app']['database']['name']}'"
      end
    end
    
    if node['app']['database']['force_update']
      symfony2_console "doctrine:schema:update --force" do
        action :cmd
        command "doctrine:schema:update --force"
        path path
      end
    end
    
  end
  
  mod_php_apache2 do
    webapp_template "vhost.conf.erb"
  end
end