
require 'csv'
require_relative '../lib/validator.rb'
require_relative '../lib/state_processor.rb'

begin
  state_processor = StateProcessor.new

  ARGV.each do |file|
    validator = Validator.new(file, state_processor.valid_state_codes)
    validator.validate
  end

rescue StandardError => err
  puts "\nAn error has occurred: #{err.message}"
end



