require "rails_helper"

RSpec.feature "Login" do
  scenario "User Logs in" do
    visit "/sessions/new"

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "jjj"
    fill_in "Password confirmation", :with => "jjj"
    click_button "Log In or Sign Up"

    expect(page).to have_text("any@gmail.com")
  end

  scenario "User Logs in with wrong confirmation password" do
    User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")

    visit "/sessions/new"

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "jjj"
    fill_in "Password confirmation", :with => "frankly"
    click_button "Log In or Sign Up"

    expect(current_path).to eq(root_path)
  end

  scenario "User Logs in with repeat email" do
    User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")

    visit "/sessions/new"

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "frankly"
    fill_in "Password confirmation", :with => "frankly"
    click_button "Log In or Sign Up"

    expect(current_path).to eq(root_path)
  end
end
