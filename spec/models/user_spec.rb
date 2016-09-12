require 'rails_helper'

RSpec.describe User, type: :model do

  context 'relationships' do
    it { should have_many(:links) }  
  end

  it "can create a new user" do
    user = User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")

    expect(User.count).to eq(1)
    expect(user.email).to eq("any@gmail.com")
  end

  it "can find a user" do
    user = User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")

    expect(User.count).to eq(1)
    expect(user.email).to eq("any@gmail.com")

    retrieved_user = User.find_by(email: "any@gmail.com")
    expect(retrieved_user.id).to eq(user.id)
  end
end
