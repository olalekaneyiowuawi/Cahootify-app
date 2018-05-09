require "net/http"
require "csv"
class CsvImporter
  attr_reader :result
  def initialize(url:)
    @url = url
    @result = []
  end

  def call
    pull_csv_text
    parse_csv_text
  end

  private

  attr_reader :url, :csv_text

  def pull_csv_text
    uri = URI(url)
    @csv_text = Net::HTTP.get(uri)
  end

  def parse_csv_text
    CSV.parse(csv_text, headers: true) do |row|
      data = { name: row[0], email: row[1], phone_number: row[2],
                                            website: row[3] }
      @result << data
    end
  end
end
