## CSV Data Validation Code Test

This is a command-line program which validates data in CSV files based on the following rules:

* Names cannot be less than four characters.
* The code denoting state must be in the file states.csv.
* The salary must be an integer, and not a float.
* The postcode must exist.

### How To Run

* Clone this repository.
* Run `ruby csv_data_validator.rb` from within the \bin folder, supplying any files you wish to validate as arguments.
* Example: `ruby csv_data_validator.rb ..\data\data1.csv ..\data\data2.csv`.

### How To Test

Run `bundle` to get RSpec, and then `rspec spec` from the root folder to run all tests.

### Output

The program will output warnings and errors as follows:

* File doesn't exist - Outputs "File Not Found" message.
* File isn't a valid CSV - Outputs "Malformed CSV" message.
* Name, State or Salary is invalid - Outputs "WARNING" message.
* Postcode is invalid - Outputs "ERROR" message.

Note:  The brief was to raise an error when the postcode was invalid, however I chose to output the "ERROR" message instead
so the program could continue running. I have commented out the line where a custom PostcodeNotFound error would be raised.

### Limitations

Currently the program isn't checking for the existence of the Name/Salary/State/Postcode columns
within the CSV file, this is something which could be added in future to improve the code.



