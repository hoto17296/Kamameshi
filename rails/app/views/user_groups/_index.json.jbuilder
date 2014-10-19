json.array!(user_groups) do |user_group|
  json.extract! user_group, :id, :answers
  json.user do
    json.name user_group.user.name
  end
end
