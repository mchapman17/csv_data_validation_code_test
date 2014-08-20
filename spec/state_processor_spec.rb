require 'spec_helper'

describe StateProcessor do

  let(:processor) { processor = StateProcessor.new }

  pending "initial state" do

    it "responds to 'valid_state_codes'" do
      expect(processor).to respond_to(:valid_state_codes)
    end

    it "assigns valid state codes based on the supplied CSV file" do

    end
  end

end
