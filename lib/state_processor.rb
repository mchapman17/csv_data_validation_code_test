class StateProcessor

  attr_accessor :valid_state_codes

  STATES_FILE = File.join(File.dirname(__FILE__), '../data/states.csv')

  def initialize
    @valid_state_codes = get_valid_state_codes
  end


  private

    def get_valid_state_codes
      fail LoadError, "States file not found" unless File.file?(STATES_FILE)
      valid_state_codes = []
      CSV.foreach(STATES_FILE, skip_blanks: true) do |row|
        valid_state_codes << row[0].to_i unless row[0].to_s.strip.empty?
      end
      valid_state_codes
    end

end