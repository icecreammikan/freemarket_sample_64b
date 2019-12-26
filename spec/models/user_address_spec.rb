require "rails_helper"

describe UserAddress do
  describe "create" do
    it "名字が空では登録できない" do
      user_address = build(:user_address, a_last_name: "")
      user_address.valid?
      expect(user_address.errors[:a_last_name]).to include("を入力してください")
    end

    it "名字に漢字以外が含まれると登録できない" do
      user_address = build(:user_address, a_last_name: "嗚呼a")
      user_address.valid?
      expect(user_address.errors[:a_last_name]).to include("は不正な値です")
    end

    it "名前が空では登録できない" do
      user_address = build(:user_address, a_first_name: "")
      user_address.valid?
      expect(user_address.errors[:a_first_name]).to include("を入力してください")
    end

    it "名前に漢字以外が含まれると登録できない" do
      user_address = build(:user_address, a_first_name: "嗚呼a")
      user_address.valid?
      expect(user_address.errors[:a_first_name]).to include("は不正な値です")
    end

    it "郵便番号が空では登録できない" do
      user_address = build(:user_address, postcode: "")
      user_address.valid?
      expect(user_address.errors[:postcode]).to include("を入力してください")
    end

    it "郵便番号が7文字以外では登録できない" do
      user_address = build(:user_address, postcode: "11111111")
      user_address.valid?
      expect(user_address.errors[:postcode]).to include("は7文字で入力してください")
    end

    it "郵便番号に数字以外が含まれると登録できない" do
      user_address = build(:user_address, postcode: "1111aa1")
      user_address.valid?
      expect(user_address.errors[:postcode]).to include("は不正な値です")
    end

    it "都道府県が空では登録できない" do
      user_address = build(:user_address, prefecture_id: "")
      user_address.valid?
      expect(user_address.errors[:prefecture_id]).to include("を入力してください")
    end

    it "市区町村が空では登録できない" do
      user_address = build(:user_address, city: "")
      user_address.valid?
      expect(user_address.errors[:city]).to include("を入力してください")
    end

    it "番地が空では登録できない" do
      user_address = build(:user_address, address: "")
      user_address.valid?
      expect(user_address.errors[:address]).to include("を入力してください")
    end

    it "全てを満たしていれば登録可能" do
      user_address = build(:user_address)
      expect(user_address).to be_valid
    end
  end
end