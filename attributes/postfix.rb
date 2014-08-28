default[:postfix][:biff] = 'no'
default[:postfix][:append_dot_mydomain] = 'no'
default[:postfix][:smtpd_use_tls] = 'no'
default[:postfix][:smtp_sasl_auth_enable] = 'no'
default[:postfix][:myhostname] = node[:fqdn]
default[:postfix][:smtpd_banner] = '$myhostname ESMTP $mail_name'
default[:postfix][:alias_maps] = 'hash:/etc/aliases'
default[:postfix][:alias_database] = 'hash:/etc/aliases'
default[:postfix][:relayhost] = ''
default[:postfix][:mydestination] = [node[:fqdn]]
default[:postfix][:mynetworks] = node[:email][:trusted_hosts]
default[:postfix][:inet_interfaces] = ['127.0.0.1']
default[:postfix][:inet_protocols] = 'all'
default[:postfix][:mailbox_size_limit] = 0
default[:postfix][:recipient_delimiter] = '+'
default[:postfix][:message_size_limit] = 209715200
default[:postfix][:default_transport] = 'smtp'
default[:postfix][:relay_transport] = 'smtp'
default[:postfix][:virtual_mailbox_domains] = node[:email][:domains]
default[:postfix][:virtual_mailbox_base] = '/var/mail/vhosts'
default[:postfix][:virtual_minimum_uid] = 100
default[:postfix][:virtual_uid_maps] = 'static:5000'
default[:postfix][:virtual_gid_maps] = 'static:5000'

if node[:email][:restricted]
  default[:postfix][:smtpd_sender_restrictions] = 'reject_unknown_sender_domain'
end

if node[:email][:dkim]
  default[:postfix][:smtpd_milters] = 'inet:localhost:8891'
  default[:postfix][:non_smtpd_milters] = 'inet:localhost:8891'
end
