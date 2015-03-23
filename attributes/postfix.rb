default[:email][:postfix][:biff]                    = 'no'
default[:email][:postfix][:append_dot_mydomain]     = 'no'
default[:email][:postfix][:smtpd_use_tls]           = 'no'
default[:email][:postfix][:smtp_sasl_auth_enable]   = 'no'
default[:email][:postfix][:myhostname]              = node[:fqdn]
default[:email][:postfix][:smtpd_banner]            = '$myhostname ESMTP $mail_name'
default[:email][:postfix][:alias_maps]              = 'hash:/etc/aliases'
default[:email][:postfix][:alias_database]          = 'hash:/etc/aliases'
default[:email][:postfix][:relayhost]               = ''
default[:email][:postfix][:mydestination]           = [node[:fqdn]]
default[:email][:postfix][:mynetworks]              = node[:email][:trusted_hosts]
default[:email][:postfix][:inet_interfaces]         = ['127.0.0.1']
default[:email][:postfix][:inet_protocols]          = 'all'
default[:email][:postfix][:mailbox_size_limit]      = 0
default[:email][:postfix][:recipient_delimiter]     = '+'
default[:email][:postfix][:message_size_limit]      = 209715200
default[:email][:postfix][:default_transport]       = 'smtp'
default[:email][:postfix][:relay_transport]         = 'smtp'
default[:email][:postfix][:virtual_mailbox_domains] = node[:email][:virtual_mailbox_domains]
default[:email][:postfix][:relay_domains]           = node[:email][:relay_domains]
default[:email][:postfix][:virtual_mailbox_base]    = '/var/mail/vhosts'
default[:email][:postfix][:virtual_mailbox_limit]   = 0
default[:email][:postfix][:message_size_limit]      = 20480000
default[:email][:postfix][:virtual_minimum_uid]     = 100
default[:email][:postfix][:virtual_uid_maps]        = 'static:5000'
default[:email][:postfix][:virtual_gid_maps]        = 'static:5000'

if node[:email][:restricted]
  default[:email][:postfix][:smtpd_sender_restrictions] = 'reject_unknown_sender_domain'
end

if node[:email][:dkim]
  default[:email][:postfix][:smtpd_milters]     = 'inet:localhost:8891'
  default[:email][:postfix][:non_smtpd_milters] = 'inet:localhost:8891'
end
