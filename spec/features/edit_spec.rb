require 'rails_helper'

RSpec.feature "Editing Links", :js => true do
  scenario 'has an edit button for each link' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link1 = user.links.create(title: "Google1", url_string: "http://google.com")
    link2 = user.links.create(title: "Google2", url_string: "http://google.com")
    link3 = user.links.create(title: "Google3", url_string: "http://google.com")
    links = [link1, link2, link3]
    visit links_index_path

    links.each_with_index do |link, x|
      within(".link-#{link.id}") do
        expect(page).to have_link("Edit")
      end
    end
  end

  scenario 'can change the title of the link' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google", url_string: "http://google.com")
    visit links_index_path

    within(".link-#{link.id}") do
      expect(page).to have_link("Google")
      click_link("Edit")
    end

    expect(current_path).to eq(links_edit_path(id: link.id))
    within(".edit-form") do
      fill_in "Title", :with => "Not Same Title"
      click_button "Update Link"
    end

    expect(current_path).to eq(links_index_path)
    within(".link-#{link.id}") do
      expect(page).to have_link("Not Same Title")
    end
  end


  scenario 'can change the url of the link' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google", url_string: "http://google.com")
    visit links_index_path

    within(".link-#{link.id}") do
      expect(page).to have_link("Google")
      click_link("Edit")
    end

    expect(current_path).to eq(links_edit_path(id: link.id))
    within(".edit-form") do
      fill_in "Url string", :with => "http://gmail.com"
      click_button "Update Link"
    end

    expect(current_path).to eq(links_index_path)
    within(".link-#{link.id}") do
      expect(page).to have_link('Google', :href => 'http://gmail.com')
    end
  end

  scenario 'can change both title and url of the link' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google", url_string: "http://google.com")
    visit links_index_path

    within(".link-#{link.id}") do
      expect(page).to have_link('Google', :href => 'http://google.com')
      click_link("Edit")
    end

    expect(current_path).to eq(links_edit_path(id: link.id))
    within(".edit-form") do
      fill_in "Title", :with => "Gmail"
      fill_in "Url string", :with => "http://gmail.com"
      click_button "Update Link"
    end

    expect(current_path).to eq(links_index_path)
    within(".link-#{link.id}") do
      expect(page).to have_link('Gmail', :href => 'http://gmail.com')
    end
  end

  scenario 'cannot change to a bad url' do
    user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    link = user.links.create(title: "Google", url_string: "http://google.com")
    visit links_index_path

    expect(Link.count).to eq(1)
    within(".link-#{link.id}") do
      expect(page).to have_link('Google', :href => 'http://google.com')
      click_link("Edit")
    end

    within(".edit-form") do
      fill_in "Title", :with => "Bad Url"
      fill_in "Url string", :with => "bad url"
      click_button "Update Link"
    end

    expect(current_path).to eq(links_index_path)
    expect(Link.count).to eq(1)
    within(".link-#{link.id}") do
      expect(page).to have_link('Google', :href => 'http://google.com')
    end
  end
end
