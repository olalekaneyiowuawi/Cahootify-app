require "rails_helper"

describe CsvImporter do
  describe "#call" do
    it "pulls the order and return an array of hashes representing the imported data" do
      url = "http://test.com/csv/path"
      stub_request(:get, url).to_return(body: response_body, status: 200)
      expected_result = [{name: "Olalekan", email: "eyiolekan@gmail.com",
                          phone_number: "0123456", website: nil}]
      importer = CsvImporter.new(url: url)

      importer.call
      result = importer.result

      expect(result).to eq(expected_result)
    end
  end

  describe "#successful?" do
    context "when it pulls the data successfully and status is 200" do
      it "is successful" do
        url = "http://test.com/csv/path"
        stub_request(:get, url).to_return(body: response_body, status: 200)
        expected_result = [{name: "Olalekan", email: "eyiolekan@gmail.com",
                            phone_number: "0123456", website: nil}]
        importer = CsvImporter.new(url: url)

        importer.call

        expect(importer).to be_successful
      end
    end
  end

  def response_body
    "Name,Email Address,Telephone Number,Website\nOlalekan,eyiolekan@gmail.com,0123456,\n"
  end
end
