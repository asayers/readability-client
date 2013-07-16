Readability CLI
===============

Download your readability articles for offline reading. This script saves both
the parsed article (ie. text only) and the full original webpage, the former in
markdown and the latter as a pdf. Files are saved to ~/.readability. [BSD
3-clause][2] licensed.

Usage
-----

- `readability` - download the 20 most recent articles
- `readability -c` - download all articles
- `readability -h` - display help text

Requirements
------------

You need to save your readability API [access token and secret][1] in ~/.netrc
under the `readability` machine. You'll need have ruby installed, as well as
the `readit`, `netrc`, `html_massage`, and `nokogiri` gems. You also need to
have `wkpdftohtml` in your path.


[1]: http://www.readability.com/account/api
[2]: http://www.asayers.org/LICENCE
