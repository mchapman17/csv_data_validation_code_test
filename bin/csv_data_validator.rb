
require 'csv'
require_relative '../lib/validator.rb'
require_relative '../lib/state_processor.rb'

begin
  state_processor = StateProcessor.new
  validator = Validator.new(valid_state_codes: state_processor.valid_state_codes)

  ARGV.each do |file|
    begin
      validator.validate(file)
    rescue CSV::MalformedCSVError
      puts "Malformed CSV file: #{file}"
      next
    end
  end

# rescue StandardError => err
#   puts "\nAn error has occurred: #{err.message}"
end



