#
# Cookbook Name:: email
# Recipe:: postfix
#
# Copyright 2014, Maxim Filatov
#
# MIT Licence
#

package 'postfix'

service 'postfix' do
  supports restart: true, status: true, reload: true
  action [:enable]
end

directory node[:email][:postfix][:virtual_mailbox_base] do
  owner 'postfix'
  group 'postfix'
  mode  0755
  recursive true
end

template '/etc/postfix/main.cf' do
  source 'main.cf.erb'
  mode 0644
  notifies :restart, 'service[postfix]'
end

if node[:email][:sasl]
  include_recipe 'email::sasl'
end
