require 'rails_helper'

describe Address do
  describe '#create' do
    it "is valid " do
      user    = create(:user)
      address = build(:address, user_id: user.id)
      address.valid?
      expect(address).to be_valid
    end

    it "is valid without building" do
      user    = create(:user)
      address = build(:address, user_id: user.id, building: "")
      address.valid?
      expect(address).to be_valid
    end

    it "is valid without phone number" do
      user    = create(:user)
      address = build(:address, user_id: user.id, phone_number: "")
      address.valid?
      expect(address).to be_valid
    end

    it "is invalid without postcode" do
      user    = create(:user)
      address = build(:address, user_id: user.id, postcode: "")
      address.valid?
      expect(address.errors[:postcode]).to include("を入力してください")
    end

    it "is invalid without prefecture" do
      user    = create(:user)
      address = build(:address, user_id: user.id, prefecture: nil)
      address.valid?
      expect(address.errors[:prefecture]).to include("を入力してください")
    end

    it "is invalid without city" do
      user    = build(:user)
      address = build(:address, user_id: user.id, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "is invalid without block" do
      user    = build(:user)
      address = build(:address, user_id: user.id, block: "")
      address.valid?
      expect(address.errors[:block]).to include("を入力してください")
    end

    # it "is invalid with incorrect postcode format" do
    #   user    = build(:user)
    #   address = build(:address, user_id: user.id, postcode: "123-4567")
    #   address.valid?
    #   expect(address.errors[:postcode]).to include("は不正な値です")
    # end
  end
end