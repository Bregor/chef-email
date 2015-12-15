#
# Cookbook Name:: email
# Recipe:: sasl
#
# Copyright 2015, Maxim Filatov
#
# MIT Licence
#

case node.platform_family
when 'debian'
  package 'libsasl2-modules'
when 'rhel'
  package 'cyrus-sasl-plain'
end

sasl_keys = Chef::DataBag.load(node[:email][:sasl_auth_databag]).keys.map do |key|
  Chef::EncryptedDataBagItem.load(node[:email][:sasl_auth_databag], key)
end

service 'postfix' do
  action :nothing
  supports restart: true
end

bash 'sasl_rehash' do
  code "/usr/sbin/postmap #{node[:email][:sasl_auth_file]}"
  action :nothing
  notifies :restart, 'service[postfix]', :delayed
end

template node[:email][:sasl_auth_file] do
  source 'sasl_passwd.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables credentials: sasl_keys
  notifies :run, 'bash[sasl_rehash]'
end
