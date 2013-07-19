Readability CLI
===============

You know you're going to be without internet access for a while and want to
catch up on your reading. You have a tonne of stuff queued up on
[Readability][3], and it's all downloaded on your phone - but really, you don't
want to be squinting at a 3-inch screen. Conundrum!

This script will download your Readability articles for offline reading. It
saves the parsed article (ie. text only) as a markdown document, as well as the
full original webpage as a pdf. Files are saved to ~/.readability. [BSD
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
[2]: http://www.asayers.org/files/LICENCE
[3]: http://www.readability.com
