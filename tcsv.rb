#!/usr/bin/env ruby
require 'csv'

def quote(text)
  "\"#{text}\""
end

ARGV.each do |file|
  next unless File.exists?(file)
  in_file   = File.open(file, "r:windows-1251:utf-8")
  base_path = File.join(File.dirname(file), File.basename(file, '.txt'))
  out_file  = File.open("#{base_path}.csv", "w:windows-1251:utf-8")
  in_file.each_line do |line|
    CSV.parse(line.gsub(/\"|\r/, ''), {:col_sep => "\t", encoding: "r:windows-1251:utf-8"}) do |row|
      out_file.puts(row.map {|column| quote(column)}.join(","))
    end
  end
  in_file.close
  out_file.close
end