require 'rails_helper'

RSpec.feature "Filter by 'Read' status", :js => true do
  scenario 'Filter for read when no read links present' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google", url_string: "http://google.com")
    visit links_index_path

    expect(link.read).to eq(false)
    within("#searchDiv") do
      click_button("Read")
    end

    within('#linksDiv') do
      expect(page).to have_no_text("Google")
    end
  end

  scenario 'Filter for read when mix of read and unread are present' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Google1", url_string: "http://google.com")
    link2 = user.links.create(title: "Google2", url_string: "http://google.com", read: true)
    visit links_index_path

    expect(link1.read).to eq(false)
    expect(link2.read).to eq(true)
    within("#searchDiv") do
      click_button("Read")
    end

    within('#linksDiv') do
      expect(page).to have_no_text("Google1")
      expect(page).to have_text("Google2")
    end
  end

  scenario 'Filter for unread when no unread links present' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google", url_string: "http://google.com", read: true)
    visit links_index_path

    expect(link.read).to eq(true)
    within("#searchDiv") do
      click_button("Unread")
    end

    within('#linksDiv') do
      expect(page).to have_no_text("Google")
    end
  end

  scenario 'Filter for unread when mix of read and unread are present' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Google1", url_string: "http://google.com")
    link2 = user.links.create(title: "Google2", url_string: "http://google.com", read: true)
    visit links_index_path

    expect(link1.read).to eq(false)
    expect(link2.read).to eq(true)
    within("#searchDiv") do
      click_button("Unread")
    end

    within('#linksDiv') do
      expect(page).to have_text("Google1")
      expect(page).to have_no_text("Google2")
    end
  end
end
