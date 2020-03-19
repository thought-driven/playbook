#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

base_file_name = 'How We Work.html'
add_before_body = <<~HTML
  <script src='/assets/script.js'></script>
  <link rel="stylesheet" href="/assets/styles.css"/>
HTML

# Add header/footer via JS
Dir.glob('**/*.html').each do |file_name|
  tempfile = File.open('file.tmp', 'w')
  file = File.open(file_name)

  file.each do |line|
    if line.downcase.include? '</body>'
      body_index = line.downcase.index '</body>'
      tempfile << line.slice(0, body_index) if body_index.positive?
      tempfile << add_before_body
      tempfile << line.slice(body_index, line.length)
    else
      tempfile << line
    end
  end

  file.close
  tempfile.close

  file_name = 'index.html' if file_name == base_file_name

  FileUtils.mv('file.tmp', file_name)
end
