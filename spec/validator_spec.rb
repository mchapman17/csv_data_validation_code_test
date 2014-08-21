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

  describe "#validate" do

    describe "when the file doesn't exist" do

      it "returns false if the file doesn't exist" do
        validator = Validator.new('INVALID FILE')
        expect(validator.validate).to eq false
      end
    end

    describe "when the file is a valid csv" do

      before do
        @validator = Validator.new("file", [1])
        allow(@validator).to receive(:file_exists?).and_return(true)
        allow(File).to receive(:basename).and_return("file")
        @valid_data = { "Name" => "Michael", "State" => 1, "Salary" => 50000, "Postcode" => 3456 }
      end

      it "doesn't output anything when the data is valid" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data)
        expect { @validator.validate }.to output("").to_stdout
      end

      it "outputs a warning if the name is less than four characters" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("Name" => "Tom"))
        expect { @validator.validate }.to output(/WARNING/).to_stdout
      end

      it "outputs a warning if the state code is not valid" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("State" => 0))
        expect { @validator.validate }.to output(/WARNING/).to_stdout
      end

      it "outputs a warning if the salary is not an integer" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("Salary" => 50000.9))
        expect { @validator.validate }.to output(/WARNING/).to_stdout
      end

      it "outputs an error if the postcode doesn't exist" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("Postcode" => nil))
        expect { @validator.validate }.to output(/ERROR/).to_stdout
      end
    end
  end

end
