require "net/http"
require "csv"

class CsvImporter
  attr_reader :result
  def initialize(url:)
    @url = url
    @result = []
    @success = nil
  end

  def call
    pull_csv_text
    process_response
  end

  def successful?
    @success
  end

  private

  attr_reader :url, :response

  def pull_csv_text
    uri = URI(url)
    @response = Net::HTTP.get_response(uri)
  rescue StandardError => e
    handle_error(e) 
  end

  def process_response
    if response.is_a?(Net::HTTPSuccess)
      @success = true
      parse_csv_text(response.body)
    else
      @success = false
    end
  end

  def parse_csv_text(csv_text)
    CSV.parse(csv_text, headers: true) do |row|
      data = { name: row[0], email: row[1], phone_number: row[2],
                                            website: row[3] }
      @result << data
    end
  end

  def handle_error(error)
    @success = false
    Rails.logger.error error
  end
end
