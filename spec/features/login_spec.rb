require "rails_helper"

RSpec.feature "Login" do
  scenario "User Logs in" do
    User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")
    visit login_path

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "jjj"
    click_button "Log In"

    expect(page).to have_text("Hello any@gmail.com")
    expect(page).to have_text("Sign Out")
    expect(current_path).to eq(links_index_path)
  end

  scenario "User Logs in bad email" do
    User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")
    visit login_path

    fill_in "Email", :with => "wrong@gmail.com"
    fill_in "Password", :with => "jjj"
    click_button "Log In"

    expect(current_path).to eq(login_path)
  end

  scenario "User Logs in bad password" do
    User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")
    visit login_path

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "fred"
    click_button "Log In"

    expect(current_path).to eq(login_path)
  end

  scenario "User Signs Out" do
    User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")

    visit "/sessions/new"

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "jjj"
    click_button "Log In"

    expect(page).to have_text("any@gmail.com")
    expect(page).to have_text("Sign Out")

    click_link "Sign Out"
    expect(current_path).to eq(root_path)
  end
end
