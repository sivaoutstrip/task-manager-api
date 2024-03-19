json.data do
  json.email @user.email
  json.token @user.jwt_token
end
