require 'rails_helper'

describe User do
  describe '#create' do
    it "nicknameが空では登録不可" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "nicknameが20文字より多ければ登録不可" do
      user = build(:user, nickname: "亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜亜")
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end

    it "emailが空では登録不可" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "emailが重複すると登録不可" do
      create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "emailが@を含まないと登録不可" do
      user = build(:user, email: "aaaaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "emailの@の前に文字が無いと登録不可" do
      user = build(:user, email: "@aaaaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "emailの@の後に文字が無いと登録不可" do
      user = build(:user, email: "aaaaa@")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "emailの@の後に.が含まれないと登録不可" do 
      user = build(:user, email: "aaaaa@aaaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "passwordに最低1文字の英語が含まれていないと登録不可" do
      user = build(:user, password: "11111111")
      user.valid?
      expect(user.errors[:password]).to include("は不正な値です")
    end

    it "passwordに最低1文字の数字が含まれていないと登録不可" do
      user = build(:user, password: "aaaaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は不正な値です")
    end

    it "passwordが6文字以下では登録不可" do
      user = build(:user, password: "aa111")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "名字が空では登録できない" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    it "名字が漢字以外が含まれると登録できない" do
      user = build(:user, last_name: "鳴呼嗚呼a")
      user.valid?
      expect(user.errors[:last_name]).to include("は不正な値です")
    end

    it "名前が空では登録できない" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "名前が漢字以外が含まれると登録できない" do
      user = build(:user, first_name: "嗚呼嗚呼a")
      user.valid?
      expect(user.errors[:first_name]).to include("は不正な値です")
    end

    it "名字（カナ）が空では登録できない" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end

    it "名前（カナ）が空では登録できない" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    it "名字（カナ）がカタカナ以外が含まれると登録できない" do
      user = build(:user, last_name_kana: "アイウエオa")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("は不正な値です")
    end

    it "名前（カナ）がカタカナ以外が含まれると登録できない" do
      user = build(:user, first_name_kana: "アイウエオa")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は不正な値です")
    end

    it "誕生年が空では登録できない" do
      user = build(:user, birthyear_id: "")
      user.valid?
      expect(user.errors[:birthyear_id]).to include("を入力してください")
    end

    it "誕生月が空では登録できない" do
      user = build(:user, birthmonth_id: "")
      user.valid?
      expect(user.errors[:birthmonth_id]).to include("を入力してください")
    end

    it "誕生日が空では登録できない" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    it "電話番号が空では登録できない" do
      user = build(:user, phone_number: "")
      user.valid?
      expect(user.errors[:phone_number]).to include("を入力してください")
    end

    it "電話番号に数字以外が含まれると登録できない" do
      user = build(:user, phone_number: "00000-00000")
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end

    it "電話番号が10文字以下では登録できない" do
      user = build(:user, phone_number: "000000000")
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end

    it "電話番号が11文字以上では登録できない" do
      user = build(:user, phone_number: "000000000000")
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end

    it "認証番号が空では登録できない" do
      user = build(:user, authentication_number: "")
      user.valid?
      expect(user.errors[:authentication_number]).to include("を入力してください")
    end

    it "認証番号が数字以外では登録できない" do
      user = build(:user, authentication_number: "アイウエオ")
      user.valid?
      expect(user.errors[:authentication_number]).to include("は数値で入力してください")
    end

    it "全てを満たしていれば登録可能" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end