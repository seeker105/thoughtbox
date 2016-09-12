require 'rails_helper'

RSpec.describe Link, type: :model do
  context "relationships" do
    it { should belong_to(:user) }
  end
end
