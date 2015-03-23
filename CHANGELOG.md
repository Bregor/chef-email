email CHANGELOG
===============

This file is used to list changes made in each version of the email cookbook.

0.0.2
------
* General: divide `email[:domains]` to `email[:relay_domains]` and `email[:virtual_mailbox_domains]`.
  **Backward incompatible** change!
* Postfix: `virtual_mailbox_limit` turned off
* Postfix: `message_size_limit` set to 20Mb

0.0.1
------
- [Maxim Filatov] - Initial release of email

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
