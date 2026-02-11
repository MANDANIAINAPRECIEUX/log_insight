#!/usr/bin/env ruby

require_relative "../lib/log_insight"

if ARGV.empty?
  puts "Usage: log_insight <log_file>"
  exit 1
end

log_file = ARGV[0]
LogInsight.run(log_file)
