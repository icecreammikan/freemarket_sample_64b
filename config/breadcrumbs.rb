crumb :root do
  link "トップページ", root_path
end

crumb :mypage_index do
  link "マイページ", mypage_index_path
  parent :root
end

crumb :mypage_profile do
  link "プロフィール", mypage_profile_path
end

crumb :mypage_card do
  link "支払い方法", mypage_card_path
end

crumb :mypage_identification do
  link "本人情報の登録", mypage_identification_path
end

crumb :mypage_logout do
  link "ログアウト", mypage_logout_path
end


