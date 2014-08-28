default[:email][:domains] = ['example.com']
default[:email][:databag] = 'domainkeys'
default[:email][:trusted_hosts] = ['127.0.0.0/8', '[::ffff:127.0.0.0]/104', '[::1]/128']
default[:email][:dkim] = true
default[:email][:restricted] = true
