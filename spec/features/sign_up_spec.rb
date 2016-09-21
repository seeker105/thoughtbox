require "rails_helper"

RSpec.feature "Login" do
  scenario "User signs up" do
    visit sign_up_path

    fill_in "Email", :with => "test_user@gmail.com"
    fill_in "Password", :with => "jjj"
    fill_in "Password confirmation", :with => "jjj"
    click_button "Create User"

    expect(page).to have_text("Welcome test_user@gmail.com")
    expect(page).to have_text("Hello test_user@gmail.com")
    expect(page).to have_text("Sign Out")
    expect(current_path).to eq(links_index_path)
  end

  scenario "User signs up with wrong confirmation password" do
    visit sign_up_path

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "jjj"
    fill_in "Password confirmation", :with => "frankly"
    click_button "Create User"

    expect(page).to have_text("Password confirmation doesn't match Password")
    expect(current_path).to eq(sign_up_path)
  end

  scenario "User signs up with repeat email" do
    User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")

    visit sign_up_path

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "frankly"
    fill_in "Password confirmation", :with => "frankly"
    click_button "Create User"

    expect(page).to have_text("Email has already been taken")
    expect(current_path).to eq(sign_up_path)
  end

  scenario "User Signs Out" do
    visit sign_up_path

    fill_in "Email", :with => "any@gmail.com"
    fill_in "Password", :with => "jjj"
    fill_in "Password confirmation", :with => "jjj"
    click_button "Create User"

    expect(page).to have_text("any@gmail.com")
    expect(page).to have_text("Sign Out")

    click_link "Sign Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_text("Log In")
    expect(page).to have_text("Sign Up")
    expect(page).to have_no_text("Hello any@gmail.com")
  end
end
