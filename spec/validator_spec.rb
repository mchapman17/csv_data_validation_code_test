require 'spec_helper'

describe Validator do

  let(:validator) { validator = Validator.new }

  describe "initial state" do

    it "responds to 'valid_state_codes'" do
      expect(validator).to respond_to(:valid_state_codes)
    end
  end

  describe "#validate(file)" do

    describe "when the file doesn't exist" do

      it "returns false if the file doesn't exist" do
        expect(validator.validate('invalid file')).to eq false
      end
    end

    describe "when the file is a malformed csv" do

      it "raises an error" do
        expect {
          validator.validate(File.join(File.dirname(__FILE__), '/support/malformed.csv'))
        }.to raise_error(CSV::MalformedCSVError)
      end
    end

    describe "when the file is a valid csv" do

      before do
        @validator = Validator.new(valid_state_codes: [1])
        @valid_data = { "Name" => "Michael", "State" => 1, "Salary" => 70000, "Postcode" => 3456 }
        allow_any_instance_of(Validator).to receive(:file_exists?).and_return(true)
      end

      it "doesn't output anything when the data is valid" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data)
        expect { @validator.validate("valid file") }.to output("").to_stdout
      end

      it "outputs a warning if the name is less than four characters" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("Name" => "Tom"))
        expect { @validator.validate("valid file") }.to output(/WARNING/).to_stdout
      end

      it "outputs a warning if the state code is not valid" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("State" => 0))
        expect { @validator.validate("valid file") }.to output(/WARNING/).to_stdout
      end

      it "outputs a warning if the salary is not an integer" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("Salary" => 50000.99))
        expect { @validator.validate("valid file") }.to output(/WARNING/).to_stdout
      end

      it "outputs an error if the postcode doesn't exist" do
        allow(CSV).to receive(:foreach).and_yield(@valid_data.merge!("Postcode" => nil))
        expect { @validator.validate("valid file") }.to output(/ERROR/).to_stdout
      end
    end
  end

end
