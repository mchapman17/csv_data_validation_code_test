require 'spec_helper'

describe Validator do

  let(:validator) { validator = Validator.new }

  describe "initial state" do

    it "responds to 'file'" do
      expect(validator).to respond_to(:file)
    end

    it "responds to 'valid_state_codes'" do
      expect(validator).to respond_to(:valid_state_codes)
    end
  end

  pending "#validate" do

    it "returns false if the file doesn't exist" do
      validator = Validator.new('INVALID FILE')
      expect(validator.validate).to eq false
    end

    context "when validating the name" do

      it "outputs a warning if the name is less than four characters" do
        # CSV.stub(:foreach).and_yield()
      end

      it "doesn't output a warning if the name is four or more characters" do

      end
    end

    context "when validating the state code" do

      it "outputs a warning if the state code is not valid" do

      end

      it "doesn't output a warning if the state code is valid" do

      end
    end

    context "when validating the salary" do

      it "outputs a warning if the salary is not an integer" do

      end

      it "doesn't output a warning if the salary is an integer" do

      end
    end

    context "when validating the postcode" do

      it "outputs an error if the postcode doesn't exist" do

      end

      it "doesn't output an error if the postcode exists" do

      end
    end
  end

end
