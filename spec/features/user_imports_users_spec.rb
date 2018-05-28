require "rails_helper"
feature "user trues to import Csv" do
  scenario "sees the number of records created" do
    url = "http://test.com"
    stub_request(:get, url).to_return(body: response_body, status: 200)

    visit new_import_csv_path
    fill_in "url", with: "http://test.com"
    click_on "Import Users"

    expect(page).to have_content("1 records were created")
  end

  def response_body
    "Name,Email Address,Telephone Number,Website\nOlalekan,eyiolekan@gmail.com,0123456,\n"
  end
end
