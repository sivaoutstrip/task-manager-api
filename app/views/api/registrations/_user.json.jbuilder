json.user do
  json.id user.id
  json.email user.email
end
json.token user.jwt_token
