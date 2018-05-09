require "rails_helper"

describe MoviesCreator do
  describe "#call" do
    it "delegates to ImportCsv to import data" do
      url = "http://test.com"
      movie_creator = MoviesCreator.new(url: url)
      csv_importer = CsvImporter.new(url: url)
      allow(csv_importer).to receive(:call)
      allow(CsvImporter).to receive(:new).and_return(csv_importer)

      movie_creator.call

      expect(csv_importer).to have_received(:call)
    end

    it "creates the mobies using the imported data" do
      url = "http://test.com"
      data = [{name: "Olalekan", email: "eyiolekan@gmail.com",
               phone_number: "0123456", website: nil}]
      movie_creator = MoviesCreator.new(url: url)
      csv_importer = CsvImporter.new(url: url)
      allow(csv_importer).to receive(:call)
      allow(CsvImporter).to receive(:new).and_return(csv_importer)
      allow(csv_importer).to receive(:result).and_return(data)

      expect do
        movie_creator.call
      end.to change(User, :count).by(1)
    end
  end


end
