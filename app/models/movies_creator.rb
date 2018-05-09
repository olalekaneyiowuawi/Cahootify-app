class MoviesCreator
  delegate :successful?, to: :importer
  def initialize(url: url)
    @url = url
    @created = 0
  end

  def call
    import_csv_data
    create_users
  end

  def number_of_records_created
    @created
  end

  private

  attr_reader :url, :importer

  def import_csv_data
    @importer = CsvImporter.new(url: url)
    @importer.call
  end

  def create_users
    if importer.successful?
      user_hash = importer.result
      user_hash.each do |user_attributes|
        create_user(user_attributes)
      end
    end
  end

  def create_user(attributes)
    user = User.new(attributes)
    if user.save
      @created += 1
    end
  end
end
