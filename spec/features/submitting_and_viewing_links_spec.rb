require "rails_helper"

RSpec.feature "Logged in user visits the Links index", :js => true do
  scenario 'it should have the link creation form' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit links_index_path

    expect(page).to have_field("Url string")
    expect(page).to have_field("Title")
  end

  scenario 'once a link is submitted it appears on the index page' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit links_index_path

    fill_in "Url string", :with => "http://google.com"
    fill_in "Title", :with => "Google"
    click_button "Create Link"

    expect(page).to have_text("Google")
  end

  scenario 'submitting an invalid url triggers an error message' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit links_index_path

    fill_in "Url string", :with => "url with spaces"
    fill_in "Title", :with => "Bad Url"
    click_button "Create Link"

    expect(page).to have_text("Url string is not a valid URL")
    expect(page).to have_no_text("Bad Url")
  end
end
