require 'rails_helper'

RSpec.feature "Filter by search term", :js => true do
  scenario 'Search term is present' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Google", url_string: "http://google.com")
    link2 = user.links.create(title: "Gmail for me", url_string: "http://gmail.com")
    link3 = user.links.create(title: "Gmail for myself", url_string: "http://gmail.com")
    link4 = user.links.create(title: "Gmail for I", url_string: "http://gmail.com")
    visit links_index_path

    within('#searchDiv') do
      expect(page).to have_field("searchTerm")
      expect(page).to have_button("Search")
      expect(page).to have_button("Clear Search")

      fill_in "searchTerm", :with => "Gmail"
      click_button("Search")
    end

    within('#linksDiv') do
      expect(page).to have_link("Gmail for me")
      expect(page).to have_link("Gmail for myself")
      expect(page).to have_link("Gmail for I")
      expect(page).to have_no_link("Google")
    end
  end

  scenario 'Search term is not present' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Google", url_string: "http://google.com")
    link2 = user.links.create(title: "Gmail for me", url_string: "http://gmail.com")
    link3 = user.links.create(title: "Gmail for myself", url_string: "http://gmail.com")
    link4 = user.links.create(title: "Gmail for I", url_string: "http://gmail.com")
    visit links_index_path

    within('#searchDiv') do
      expect(page).to have_field("searchTerm")
      expect(page).to have_button("Search")
      expect(page).to have_button("Clear Search")

      fill_in "searchTerm", :with => "Hamburger"
      click_button("Search")
    end

    within('#linksDiv') do
      expect(page).to have_no_link("Gmail for me")
      expect(page).to have_no_link("Gmail for myself")
      expect(page).to have_no_link("Gmail for I")
      expect(page).to have_no_link("Google")
    end
  end

  scenario 'Clear the search' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Google", url_string: "http://google.com")
    link2 = user.links.create(title: "Gmail for me", url_string: "http://gmail.com")
    link3 = user.links.create(title: "Gmail for myself", url_string: "http://gmail.com")
    link4 = user.links.create(title: "Gmail for I", url_string: "http://gmail.com")
    visit links_index_path

    within('#searchDiv') do
      fill_in "searchTerm", :with => "Google"
      click_button("Search")
    end

    within('#linksDiv') do
      expect(page).to have_no_link("Gmail for me")
      expect(page).to have_no_link("Gmail for myself")
      expect(page).to have_no_link("Gmail for I")
      expect(page).to have_link("Google")
    end

    within('#searchDiv') do
      click_button("Clear Search")
    end

    within('#linksDiv') do
      expect(page).to have_link("Gmail for me")
      expect(page).to have_link("Gmail for myself")
      expect(page).to have_link("Gmail for I")
      expect(page).to have_link("Google")
    end
  end



end
