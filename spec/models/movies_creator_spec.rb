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
  end
end
