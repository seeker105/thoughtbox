require 'rails_helper'

RSpec.feature "Sort by link title", :js => true do
  scenario 'Sort a non-alphabetical list' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Carlisle", url_string: "http://google.com")
    link2 = user.links.create(title: "Alpha", url_string: "http://google.com")
    link3 = user.links.create(title: "Deuterium", url_string: "http://google.com")
    link4 = user.links.create(title: "Boron", url_string: "http://google.com")
    links = [link1, link2, link3, link4]
    visit links_index_path

    within("#searchDiv") do
      click_button("Alpha")
    end



  end
end
