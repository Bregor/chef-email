#
# Cookbook Name:: email
# Recipe:: opendkim
#
# Copyright 2014, Maxim Filatov
#
# MIT Licence
#

package 'opendkim'

service 'opendkim' do
  supports restart: true, status: true, reload: true
  action [:enable]
end

directory '/etc/opendkim/keys' do
  owner 'opendkim'
  group 'opendkim'
  mode  0700
  recursive true
end

node[:email][:domains].each do |domain|
  file "/etc/opendkim/keys/#{domain}.key" do
    owner 'opendkim'
    group 'opendkim'
    mode  0600
    content(Chef::EncryptedDataBagItem.load(node[:email][:databag], domain.gsub(/\./, '_'))['private_key'])
  end
end

template '/etc/opendkim.conf' do
  source 'opendkim.conf.erb'
  owner 'opendkim'
  group 'opendkim'
  mode 0644
  notifies :restart, 'service[opendkim]'
end

template '/etc/opendkim/KeyTable' do
  source 'key_table.erb'
  owner 'opendkim'
  group 'opendkim'
  mode 0640
  notifies :reload, 'service[opendkim]'
end

template '/etc/opendkim/SigningTable' do
  source 'signing_table.erb'
  owner 'opendkim'
  group 'opendkim'
  mode 0640
  notifies :reload, 'service[opendkim]'
end

template '/etc/opendkim/TrustedHosts' do
  source 'trusted_hosts.erb'
  owner 'opendkim'
  group 'opendkim'
  mode 0640
  notifies :reload, 'service[opendkim]'
end
