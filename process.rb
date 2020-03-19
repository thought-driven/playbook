#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

base_file_name = 'How We Work.html'
src_dir = 'src/'

def add_before_body
  <<~HTML
    <script src='/assets/script.js'></script>
    <link rel="stylesheet" href="/assets/styles.css"/>
  HTML
end

def html_file?(file_name)
  file_name.include? 'html'
end

def process_html(file_name, outfile_name)
  tempfile = File.open('file.tmp', 'w')
  file = File.open(file_name)

  file.each do |line|
    process_line(line, tempfile)
  end

  file.close
  tempfile.close

  FileUtils.mv('file.tmp', outfile_name)
end

def replace_white_space(line)
  line.gsub('%20', '_')
end

def process_line(line, tempfile)
  line = replace_white_space(line)

  # insert before end of body
  if line.downcase.include? '</body>'
    body_index = line.downcase.index '</body>'
    tempfile << line.slice(0, body_index) if body_index.positive?
    tempfile << add_before_body
    tempfile << line.slice(body_index, line.length)
  else
    tempfile << line
  end
end

Dir.glob("#{src_dir}**/*").select{ |e| File.file? e }.each do |file_name|
  p file_name
  if file_name == "#{src_dir}#{base_file_name}"
    outfile_name = 'index.html'
  else
    outfile_name = file_name.gsub(' ', '_').gsub(src_dir, '')
  end

  FileUtils.mkdir_p(File.dirname(outfile_name))

  if html_file?(file_name)
    process_html(file_name, outfile_name)
  else
    FileUtils.cp(file_name, outfile_name)
  end
end
