require 'rails_helper'

RSpec.feature "Read/Unread Links", :js => true do
  scenario 'A new link has a "mark as read" option' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google", url_string: "http://google.com")
    visit links_index_path

    within('#linksDiv') do
      expect(page).to have_link("Google")
    end
    within(".link-#{link.id}") do
      expect(page).to have_button("Mark as Read")
    end
  end

  scenario 'Multiple new links each have a "mark as read" option' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    links = []
    links.push(user.links.create(title: "Google1", url_string: "http://google.com"))
    links.push(user.links.create(title: "Google2", url_string: "http://google.com"))
    links.push(user.links.create(title: "Google3", url_string: "http://google.com"))
    visit links_index_path

    links.each do |link|
      within(".link-#{link.id}") do
        expect(page).to have_link(link.title)
        expect(page).to have_button("Mark as Read")
      end
    end
  end


  scenario 'Clicking "Mark as Read" changes the link to "read" status' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google3", url_string: "http://google.com")
    visit links_index_path

    within(".link-#{link.id}") do
      expect(page).to have_css('.unread')
      expect(page).to have_button("Mark as Read")
      click_button("Mark as Read")
      expect(page).to have_css('.read')
      expect(page).to have_button("Mark as Unread")
    end
  end

  scenario 'Clicking "Mark as Unread" changes the link to "unread" status' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google3", url_string: "http://google.com", read: true)
    visit links_index_path

    within(".link-#{link.id}") do
      expect(page).to have_css('.read')
      expect(page).to have_button("Mark as Unread")
      click_button("Mark as Unread")
      expect(page).to have_css('.unread')
      expect(page).to have_button("Mark as Read")
    end
  end
end
