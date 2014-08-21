require 'spec_helper'

describe StateProcessor do

  let(:processor) { processor = StateProcessor.new }

  describe "initial state" do

    it "responds to 'valid_state_codes'" do
      expect(processor).to respond_to(:valid_state_codes)
    end

    it "assigns valid state codes based on the supplied CSV file" do
      allow(CSV).to receive(:foreach).and_yield([1, "Tasmania"]).and_yield([2, "Victoria"])
      expect(processor.valid_state_codes).to eq [1, 2]
    end
  end

end
