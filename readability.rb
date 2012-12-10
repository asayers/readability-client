#! /usr/bin/env ruby

require 'readit'
require 'netrc'
require './reverse_markdown'

CONSUMER_KEY = "asayers"
CONSUMER_SECRET = "UncvtGWgfn8PXBzchWAmxcDqJSKa6qfC"
ACCESS_TOKEN, ACCESS_TOKEN_SECRET = Netrc.read["readability"]

STORAGE_DIR = File.join(Dir.home, ".readability")
Dir.mkdir(STORAGE_DIR) unless Dir.exists? STORAGE_DIR

puts "Synchronising..."
Readit::Config.consumer_key     = CONSUMER_KEY
Readit::Config.consumer_secret  = CONSUMER_SECRET
@api = Readit::API.new(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
@bookmarks = @api.bookmarks

@bookmarks.each do |bookmark|
  title = bookmark["article"]["title"].gsub(/ /, "_").gsub(/[^0-9A-Za-z_]/, '')
  unless Dir.entries(STORAGE_DIR).include? title
    puts "Downloading #{title}..."
    article = ReverseMarkdown.parse(@api.article(bookmark["article"]["id"]).content)
    File.open("#{STORAGE_DIR}/#{title}", 'w') do |f|
      f.puts article
    end
  end
end

puts "Articles saved to #{STORAGE_DIR}"
