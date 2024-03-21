require 'test_helper'

class Api::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should return invalid credentials if email is nil' do
    params = { email: nil, password: users(:user_one).password }
    post api_sign_in_path(params)
    assert_equal response.parsed_body['message'], 'Invalid credentials'
    assert_response :unprocessable_entity
  end

  test 'should return invalid credentials if email is not valid pattern' do
    params = { email: 'hello', password: users(:user_one).password }
    post api_sign_in_path(params)
    assert_equal response.parsed_body['message'], 'Invalid credentials'
    assert_response :unprocessable_entity
  end

  test 'should return invalid credentials if email is not present in the database' do
    params = { email: 'hello@hello.com', password: users(:user_one).password }
    post api_sign_in_path(params)
    assert_equal response.parsed_body['message'], 'Invalid credentials'
    assert_response :unprocessable_entity
  end

  test 'should return invalid credentials if password is nil' do
    params = { email: users(:user_one).email, password: nil }
    post api_sign_in_path(params)
    assert_equal response.parsed_body['message'], 'Invalid credentials'
    assert_response :unprocessable_entity
  end

  test 'should return invalid credentials if password is invalid' do
    params = { email: users(:user_one).email, password: '123' }
    post api_sign_in_path(params)
    assert_equal response.parsed_body['message'], 'Invalid credentials'
    assert_response :unprocessable_entity
  end

  test 'should return invalid credentials if password is case sensitive' do
    params = { email: users(:user_one).email, password: 'Password@01'.upcase }
    post api_sign_in_path(params)
    assert_equal response.parsed_body['message'], 'Invalid credentials'
    assert_response :unprocessable_entity
  end

  test 'should return email and token data is credentials are valid' do
    params = { email: users(:user_one).email, password: 'Password@01' }
    post api_sign_in_path(params)
    assert_equal response.parsed_body['user']['email'], users(:user_one).email
    assert_not_nil response.parsed_body['token']
    assert_response :ok
  end
end
