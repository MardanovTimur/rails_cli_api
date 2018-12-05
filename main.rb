#!/usr/bin/env ruby
require 'optparse'
require './parser'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-s", "--search [SEARCH]", String, "search by field") do |search|
    options[:search] = search
  end

  opts.on("-m", "--method [METHOD]", String, "method of api") do |method|
    options[:method] = method
  end

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!


if __FILE__ == $0
  p = Parser.new(options[:search], options[:method].nil? ? ('rest') : (options[:method]))
  puts p.list_tracks
end
