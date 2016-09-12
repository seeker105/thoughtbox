require "rails_helper"

RSpec.feature "Logged in user visits the Links index" do
  scenario 'it should have the link creation form' do
      user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit links_index_path

      expect(page).to have_field("Url string")
      expect(page).to have_field("Title")
  end

end
