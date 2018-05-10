require "rails_helper"

describe PeopleCreator do
  let(:url) { "http://test.com" }

  it { is_expected.to delegate_method(:successful?).to(:importer)}
  describe "#call" do
    it "delegates to ImportCsv to import data" do
      movie_creator = PeopleCreator.new(url: url)
      csv_importer = stub_csv_importer(url: url, success: false)

      movie_creator.call

      expect(csv_importer).to have_received(:call)
    end

    it "creates the people using the imported data" do
      data = [{name: "Olalekan", email: "eyiolekan@gmail.com",
               phone_number: "0123456", website: nil}]
      movie_creator = PeopleCreator.new(url: url)
      csv_importer = stub_csv_importer(url: url, success: true)
      allow(csv_importer).to receive(:result).and_return(data)

      expect do
        movie_creator.call
      end.to change(User, :count).by(1)
    end
  end

  def stub_csv_importer(url:, success:)
    csv_importer = CsvImporter.new(url: url)
    allow(csv_importer).to receive(:call)
    allow(CsvImporter).to receive(:new).and_return(csv_importer)
    allow(csv_importer).to receive(:successful?).and_return(success)
    csv_importer
  end

end
