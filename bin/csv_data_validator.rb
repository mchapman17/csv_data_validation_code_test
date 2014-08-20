
require 'csv'
require_relative '../lib/validator.rb'

STATES_FILE = File.join(File.dirname(__FILE__), '../data/states.csv')

def process_states_csv_file
  valid_state_codes = []
  CSV.foreach(STATES_FILE, skip_blanks: true) do |row|
    valid_state_codes << row[0].to_i unless row[0].to_s.strip.empty?
  end
  valid_state_codes
end


def file_exists?(file)
  if File.file?(file)
    true
  else
    puts "File not found: #{file}"
    false
  end
end

begin
  fail LoadError, "States file not found" unless File.file?(STATES_FILE)
  valid_state_codes = process_states_csv_file

  ARGV.each do |file|
    next unless file_exists?(file)
    validator = Validator.new(file, valid_state_codes)
    validator.validate
  end

rescue StandardError => err
  puts "\nAn error has occurred: #{err.message}"
end



