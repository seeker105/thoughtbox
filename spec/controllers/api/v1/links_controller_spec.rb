require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :controller do

  describe "GET #index" do
    it 'returns a list of Links' do
      user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      links = []
      links.push(user.links.create(title: "Google1", url_string: "http://google.com"))
      links.push(user.links.create(title: "Google2", url_string: "http://google.com"))
      links.push(user.links.create(title: "Google3", url_string: "http://google.com"))

      get :index, params: {format: :json}
      result = JSON.parse(response.body, symbolize_names: true)

      result.reverse.each_with_index do |link, x|
        expect(link[:id]).to eq(links[x].id)
        expect(link[:title]).to eq(links[x].title)
        expect(link[:url_string]).to eq(links[x].url_string)
      end
    end
  end

  describe "update" do
    it 'sets a link to read=true' do
      user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      link = user.links.create(title: "Google", url_string: "http://google.com")

      expect(link.read).to eq(false)
      patch :update, params: {format: :json, id: link.id, link: {read: true}}
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:read]).to eq(true)
      expect(response).to have_http_status(:success)
    end
  end


  describe "update" do
    it 'sets a link to read=false' do
      user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      link = user.links.create(title: "Google", url_string: "http://google.com", read: true)

      expect(link.read).to eq(true)
      patch :update, params: {format: :json, id: link.id, link: {read: false}}
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:read]).to eq(false)
      expect(response).to have_http_status(:success)
    end
  end

end
