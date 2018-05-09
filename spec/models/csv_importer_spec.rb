require "rails_helper"

describe CsvImporter do
  describe "#call" do
    it "pulls the order and return an array of hashes representing the imported data" do
      url = "http://test/csv/path"
      body = "Name,Email Address,Telephone Number,Website
      Olalelekan,eyiolekan@gmail.com,0123456,\n"
      stub_request(:get, url).with(body: body)
      expected_result = [{name: "Olalekan", email: "eyiolekan@gmail.com",
                          phone_number: "0123456", website: nil}]
      importer = CsvImporter.new(url: url)

      impporter.call
      result = importer.result
  
      expect(result).to eq(expected_result)
    end
  end
end
