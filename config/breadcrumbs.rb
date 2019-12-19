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
  link "カード", mypage_card_path
end

crumb :mypage_identification do
  link "本人情報の登録", mypage_identification_path
end

crumb :mypage_logout do
  link "ログアウト", mypage_logout_path
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).