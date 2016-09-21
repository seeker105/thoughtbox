require 'rails_helper'

RSpec.describe Link, type: :model do
  context "relationships" do
    it { should belong_to(:user) }
  end

  context "urls" do
    it 'should accept valid urls' do
      user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
      link = user.links.new(title: "Google", url_string: "http://google.com")
      expect(link.save).to eq(true)
    end

    it 'should reject invalid urls' do
      user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
      link = user.links.new(title: "Google", url_string: "bad url")
      expect(link.save).to eq(false)
    end
  end

  context "defaults" do
    it 'should default to read=false' do
      user = User.create(email: "test@user.com", password: "jjj", password_confirmation: "jjj")
      link = user.links.create(title: "Google", url_string: "http://google.com")
      expect(link.read).to eq(false)
    end
  end
end
