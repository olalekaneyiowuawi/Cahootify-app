class MoviesCreator
  def initialize(url: url)
    @url = url
  end

  def call
    import_csv_data
  end

  private

  attr_reader :url, :importer

  def import_csv_data
    @importer = CsvImporter.new(url: url)
    @importer.call
  end
end
