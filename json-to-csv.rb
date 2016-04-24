#!/usr/bin/env ruby

require 'csv'
require 'json'

require_relative 'lib'
require_relative 'errors'

# Check the ruby version
major, minor = RUBY_VERSION.split('.').map &:to_i
exit_gently :ruby_version unless major == 2 && minor >= 3 || major > 2

# Extract the options
filepath = ARGV.first
exit_gently :no_args if filepath.nil?

absolute_filepath = File.expand_path filepath

# Check the JSON file does exist
unless File.exists?(absolute_filepath)
  exit_gently :file_does_not_exist, { filepath: absolute_filepath }
end

File.open(File.expand_path(filepath), 'r') do |f|
  # We then get the users and build the headers
  begin
    users = JSON.parse f.read
  rescue
    exit_gently :parse_error unless users.is_a? Array
  end

  exit_gently :array unless users.is_a? Array

  headers = build_headers users
  csv_filepath = "#{File.basename(filepath, '.*')}.csv"

  # Then we open a .csv file, populating it with properly formatted rows
  CSV.open(csv_filepath, 'wb') do |csv|
    csv << format_headers(headers)
    users.each { |user| csv << format_element(headers, user) }
    puts "#{csv_filepath} has been created"
  end
end
