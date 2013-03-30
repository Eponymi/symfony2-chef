symfony2-chef Cookbook
=====================
Symfony2 website deployment

Requirements
------------

#### operating systems

- Ubuntu 12.04

#### cookbooks

- 'apt'
- 'application'
- 'application_php'
- 'symfony2'
- 'htop'
- 'mysql'
- 'curl'
- 'java'
- 'npm'
- 'nodejs'
- 'mysql'
- 'git'
- 'php'
- 'composer'


Attributes
----------

#### symfony2-chef::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['app']['name']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>symfony</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['path']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>/site</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['repository']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>git@bitbucket.org:user/repo.git</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['deploy_key']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['app']['revision']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['force_deploy']</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['user']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>node[:apache][:user]</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['group']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>node[:apache][:group]</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['secret']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>change-me</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['packages']</tt></td>
    <td>Array</td>
    <td></td>
    <td><tt>["acl", "php5-intl", "php5-gd", "php5-curl", "php5-mysql", "php5-xdebug", "php-apc"]</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['node']['packages']</tt></td>
    <td>Array</td>
    <td></td>
    <td><tt>["less", "coffee-script"]</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['node']['install_method']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>package</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['node']['path']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['app']['node']['modules']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['app']['coffee']['path']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>/usr/local/bin/coffee</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['java']['path']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>/usr/bin/java</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['email']['name']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>Symfony</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['email']['address']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>noreply@example.com</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['transport']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>smtp</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['encryption']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>tls</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['auth_mode']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>login</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['host']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['port']</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>25</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['user']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>~</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['password']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>~</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['mailer']['enckey_path']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>/etc/chef/keys/smtp.key</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['host']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['port']</tt></td>
    <td>Integer</td>
    <td></td>
    <td><tt>~</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['name']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>symfony</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['user']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['password']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>~</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['enckey_path']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>/etc/chef/keys/mysql.key</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['force_update']</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['app']['database']['create']</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### symfony2-chef::default

Just include `symfony2-chef` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[symfony2-chef]"
  ]
}
```

Contributing
------------

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: 
- Robert Dolca

- Copyright 2013, Robert Dolca

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
