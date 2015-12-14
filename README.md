email Cookbook
==============
This cookbook installs and configures Postfix and OpenDKIM with multidomain support.
Single domain case is also available.

Attributes
----------

#### email::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['email']['dkim']</tt></td>
    <td>Boolean</td>
    <td>Indicates installing/configuring of OpenDKIM (yes, you can use only Postfix!)</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['restricted']</tt></td>
    <td>Boolean</td>
    <td>Indicates usage of `smtpd_sender_restrictions` in Postfix</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['databag']</tt></td>
    <td>String</td>
    <td>Name of databag with DKIM private keys. Items MUST be encrypted!</td>
    <td><tt>'domainkeys'</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['relay_domains']</tt></td>
    <td>Array</td>
    <td>List of relay-only domains</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
  <tr>
    <td><tt>['email'][virtual_mailbox_domains']</tt></td>
    <td>Array</td>
    <td>List of local domains</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['trusted_hosts']</tt></td>
    <td>Array</td>
    <td>List of trusted hosts for both Postfix and OpenDKIM</td>
    <td><tt>['127.0.0.0/8', '[::ffff:127.0.0.0]/104', '[::1]/128']</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['sasl']</tt></td>
    <td>Boolean</td>
    <td>Condition for using Cyrus SASL (for relayhost with SMTP-auth e.g.)</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['sasl_auth_databag']</tt></td>
    <td>String</td>
    <td>Name of databag with SASL credentials. Items MUST be encrypted!</td>
    <td><tt>sasl_secrets</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['sasl_auth_file']</tt></td>
    <td>String</td>
    <td>Path to SASL auth file</td>
    <td><tt>/etc/postfix/sasl_passwd</tt></td>
  </tr>
</table>

Usage
-----
#### email::default
At first you need a databag (named 'domainkeys' by default) with at least one encrypted item.
Item should contain key `private_key` with private DKIM key for domain as value named as item itself.
End of lines should be changed to '\n'.

Then just include `email` and list of domains to your node:

```json
{
  "name":"my_node",
  "normal": {
    "email": {
      "virtual_mailbox_domains": ["mydomain.com"],
	  "relay_domains": ["hisdomain.com","herdomain.com"]
    }
  },
  "run_list": [
    "recipe[email]"
  ]
}
```

Be sure you have proper `data_bag_items` for all your domains.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

# Sponsor

<p align="center"><a href="https://evilmartians.com/?utm_source=chef-email">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54"></a></p>

License and Authors
-------------------
The MIT License (MIT)
Copyright © 2014 Maxim Filatov <pipopolam@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
