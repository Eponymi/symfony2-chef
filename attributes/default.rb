include_attribute 'apache2'

# Application
default['app']['name'] = 'symfony'
default['app']['path'] = '/site'
default['app']['repository'] = 'git@bitbucket.org:user/repo.git'
default['app']['deploy_key'] = ''
default['app']['revision']   = 'master'
default['app']['force_deploy'] = false
default['app']['user'] = node[:apache][:user]
default['app']['group'] = node[:apache][:group]
default['app']['secret'] = "change-me"

# System packages
default['app']['packages'] = ["acl", "php5-intl", "php5-gd", "php5-curl", "php5-mysql", "php5-xdebug", "php-apc"]

# Nodejs
default['app']['node']['packages'] = ["less", "coffee-script"]
default['app']['node']['install_method'] = "package"

if default['app']['node']['install_method'] == "package"
  default['app']['node']['path'] = "/usr/bin/node"
  default['app']['node']['modules'] = "/usr/lib/node_modules"
else
  default['app']['node']['path'] = "/usr/local/bin/node"
  default['app']['node']['modules'] = "/usr/local/lib/node_modules/"
end

# Coffee Script
default['app']['coffee']['path'] = "/usr/local/bin/coffee"

# Java
default['app']['java']['path'] = "/usr/bin/java"

# Email
default['app']['email']['name'] = "Symfony"
default['app']['email']['address'] = "noreply@example.com"

# Mailer
default['app']['mailer']['transport'] = "smtp"
default['app']['mailer']['encryption'] = "tls"
default['app']['mailer']['auth_mode'] = "login"
default['app']['mailer']['host'] = "127.0.0.1"
default['app']['mailer']['port'] = "25"
default['app']['mailer']['user'] = "~"
default['app']['mailer']['password'] = "~"
default['app']['mailer']['enckey_path'] = "/etc/chef/keys/smtp.key"

# Database
default['app']['database']['host'] = "localhost"
default['app']['database']['port'] = "~"
default['app']['database']['name'] = "symfony"
default['app']['database']['user'] = "root"
default['app']['database']['password'] = "~"
default['app']['database']['enckey_path'] = "/etc/chef/keys/mysql.key"
default['app']['database']['force_update'] = false
default['app']['database']['create'] = false