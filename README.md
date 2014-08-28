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
    <td><tt>['email']['domains']</tt></td>
    <td>Array</td>
    <td>List of maintained domains</td>
    <td><tt>['example.com']</tt></td>
  </tr>
  <tr>
    <td><tt>['email']['trusted_hosts']</tt></td>
    <td>Array</td>
    <td>List of trusted hosts for both Postfix and OpenDKIM</td>
    <td><tt>['127.0.0.0/8', '[::ffff:127.0.0.0]/104', '[::1]/128']</tt></td>
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
      "domains": [
        "mydomain.com",
        "hisdomain.com",
        "herdomain.com"
      ]
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

Sponsored by [Evil Martians](http://evilmartians.com)

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
