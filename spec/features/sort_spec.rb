require 'rails_helper'

RSpec.feature "Sort by link title", :js => true do
  scenario 'Sort a non-alphabetical list' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Cadmium", url_string: "http://google.com")
    link2 = user.links.create(title: "Argon", url_string: "http://google.com")
    link3 = user.links.create(title: "Boron", url_string: "http://google.com")
    visit links_index_path

    within("#searchDiv") do
      click_button("Alpha")
    end

    within('#linksDiv') do
      page.body.should_not =~ /Cadmium.*Argon.*Boron/
      page.body.should =~ /Argon.*Boron.*Cadmium/
    end
  end

  scenario 'Sort a non-alphabetical list with an equal element' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Cadmium", url_string: "http://google.com")
    link2 = user.links.create(title: "Argon", url_string: "http://google.com")
    link1 = user.links.create(title: "Cadmium", url_string: "http://google.com")
    link3 = user.links.create(title: "Boron", url_string: "http://google.com")
    visit links_index_path

    within("#searchDiv") do
      click_button("Alpha")
    end

    within('#linksDiv') do
      page.body.should_not =~ /Cadmium.*Argon.*Cadmium.*Boron/
      page.body.should =~ /Argon.*Boron.*Cadmium.*Cadmium/
    end
  end
end
