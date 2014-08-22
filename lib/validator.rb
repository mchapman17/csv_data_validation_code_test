class Validator

  attr_accessor :valid_state_codes

  class PostcodeNotFoundError < StandardError; end

  def initialize(valid_state_codes: [])
    @valid_state_codes = valid_state_codes
  end

  def validate(file)
    return false unless file_exists?(file)
    CSV.foreach(file, { headers: true, skip_blanks: true }) do |row|
      puts "#{File.basename(file)} - Row #{$.} - WARNING: Name cannot be less than four characters" unless valid_name?(row["Name"])
      puts "#{File.basename(file)} - Row #{$.} - WARNING: State Code must exist in states.csv file" unless valid_state_code?(row["State"])
      puts "#{File.basename(file)} - Row #{$.} - WARNING: Salary must be an Integer - #{row["Salary"]}" unless valid_salary?(row["Salary"])
      puts "#{File.basename(file)} - Row #{$.} - ERROR: Postcode must exist" unless valid_postcode?(row["Postcode"])
      # fail PostcodeNotFoundError, "#{File.basename(file)} - Postcode must exist" unless valid_postcode?(row["Postcode"])
    end
  end


  private

    def file_exists?(file)
      if File.file?(file.to_s)
        true
      else
        puts "File not found: #{file}"
        false
      end
    end

    def valid_name?(name)
      name.to_s.strip.length >= 4
    end

    def valid_state_code?(code)
      valid_state_codes.include?(code.to_i)
    end

    def valid_salary?(salary)
      salary.to_f == salary.to_i
    end

    def valid_postcode?(postcode)
      !postcode.to_s.strip.empty?
    end

end