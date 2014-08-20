class Validator

  attr_accessor :file, :valid_state_codes

  class PostcodeNotFoundError < StandardError; end

  def initialize(file, valid_state_codes)
    @file = file
    @valid_state_codes = valid_state_codes || []
  end

  def validate
    CSV.foreach(file, { headers: true, skip_blanks: true }) do |row|
      warn "#{File.basename(file)} - Row #{$.} - WARNING: Name cannot be less than four characters" unless valid_name?(row["Name"])
      warn "#{File.basename(file)} - Row #{$.} - WARNING: State Code must exist in states.csv file" unless valid_state_code?(row["State"])
      warn "#{File.basename(file)} - Row #{$.} - WARNING: Salary must be an Integer" unless valid_salary?(row["Salary"])
      warn "#{File.basename(file)} - Row #{$.} - ERROR: Postcode must exist" unless valid_postcode?(row["Postcode"])
      # raise PostcodeNotFoundError, "#{File.basename(file)} - Postcode must exist" unless valid_postcode?(row["Postcode"])
    end
  end


  private

    def valid_name?(name)
      name.to_s.strip.length >= 4
    end

    def valid_state_code?(code)
      valid_state_codes.include?(code.to_i)
    end

    def valid_salary?(salary)
      !salary.is_a?(Integer)
    end

    def valid_postcode?(postcode)
      !postcode.to_s.strip.empty?
    end

end