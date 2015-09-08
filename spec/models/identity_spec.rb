require 'rails_helper'

RSpec.describe Identity, type: :model do
  describe "initialization" do
    it 'creates an identity given a provider and a uid'
    it 'retrieves an identity given a provider and a uid'
  end

  describe "validations" do
    it 'validates the presence of a provider'
    it 'validates the presence of a uid within the scope of a provider'
  end
end
