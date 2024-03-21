require 'test_helper'

class Api::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @email = 'hello@acme.com'
    @password = 'Password@02'
  end

  test 'should return unprocessable entity if email not present on signup' do
    params = { email: nil, password: @password, password_confirmation: @password }
    post api_sign_up_path(params)
    assert_includes response.parsed_body, 'Email can\'t be blank'
    assert_response :unprocessable_entity
  end

  test 'should return unprocessable entity if email is valid on signup' do
    params = { email: 'hello', password: @password, password_confirmation: @password }
    post api_sign_up_path(params)
    assert_includes response.parsed_body, 'Email is invalid'
    assert_response :unprocessable_entity
  end

  test 'should return unprocessable entity if password is empty' do
    params = { email: @email, password: nil, password_confirmation: @password }
    post api_sign_up_path(params)
    assert_includes response.parsed_body, 'Password can\'t be blank'
    assert_response :unprocessable_entity
  end

  test 'should return unprocessable entity if password is invalid' do
    params = { email: @email, password: 'hello', password_confirmation: @password }
    post api_sign_up_path(params)
    assert_includes response.parsed_body, 'Password is invalid'
    assert_response :unprocessable_entity
  end

  test 'should return unprocessable entity if password and confirmation not matched' do
    params = { email: 'hello', password: @password, password_confirmation: 'hello' }
    post api_sign_up_path(params)
    assert_includes response.parsed_body, 'Password confirmation doesn\'t match Password'
    assert_response :unprocessable_entity
  end

  test 'signed-up user should render user data with token' do
    params = { email: @email, password: @password, password_confirmation: @password }
    post api_sign_up_path(params)
    assert_response :created
    assert_equal @email, response.parsed_body.dig('user', 'email')
    assert_not_nil response.parsed_body['token']
  end
end
