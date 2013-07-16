#! /usr/bin/env ruby

require 'readit'
require 'netrc'
require 'html_massage'
require './reverse_markdown'

CONSUMER_KEY = "asayers"
CONSUMER_SECRET = "UncvtGWgfn8PXBzchWAmxcDqJSKa6qfC"
ACCESS_TOKEN, ACCESS_TOKEN_SECRET = Netrc.read["readability"]

STORAGE_DIR = File.join(Dir.home, ".readability")
Dir.mkdir(STORAGE_DIR) unless Dir.exists? STORAGE_DIR

def get_article(bookmark)
  title = bookmark["article"]["title"]
  fname = "#{title.gsub(/ /, "_").gsub(/[^0-9A-Za-z_-]/, '')}"
  puts "Downloading '#{title}'..."
  unless Dir.entries(STORAGE_DIR).include? "#{fname}.md"
    article = HtmlMassage.markdown(@api.article(bookmark["article"]["id"]).content)
    File.open("#{STORAGE_DIR}/#{fname}.md", 'w') do |f|
      f.puts article
    end
  end
  unless Dir.entries(STORAGE_DIR).include? "#{fname}.pdf"
    `wkhtmltopdf "#{bookmark["article"]["url"]}" #{STORAGE_DIR}/#{fname}.pdf`
  end
end

#puts "Synchronising..."
Readit::Config.consumer_key     = CONSUMER_KEY
Readit::Config.consumer_secret  = CONSUMER_SECRET
@api = Readit::API.new(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
recents = @api.bookmarks(include_meta: true)
pages = recents.pop.num_pages

case ARGV[0]
when "-h"
  puts "Usage: readability [-c]\n  -c  Perform complete download\n  -h  Show help"
  exit 0
when "-c"
  pages.times do |page|
    @bookmarks = @api.bookmarks(page: page+1)
    @bookmarks.each do |bookmark|
      get_article bookmark
    end
  end
else
  @bookmarks = @api.bookmarks()
  @bookmarks.each do |bookmark|
    get_article bookmark
  end
end

puts "Articles saved to #{STORAGE_DIR}"
