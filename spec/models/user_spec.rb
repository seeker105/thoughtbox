require 'rails_helper'

RSpec.describe User, type: :model do
  it "can create a new user" do
    user = User.create(email: "any@gmail.com", password: "jjj", password_confirmation: "jjj")

    expect(User.count).to eq(1)
    expect(user.email).to eq("any@gmail.com")

  end
end
