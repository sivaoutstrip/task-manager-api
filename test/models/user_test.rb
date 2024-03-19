# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  email                 :string
#  password              :string
#  password_confirmation :string
#  password_digest       :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    password = 'Password@01'
    @user = User.new(email: 'kane@acme.com', password:, password_confirmation: password)
  end

  test 'create user with valid params' do
    assert @user.save
  end

  test 'should not save record if email is nil' do
    @user.email = nil
    assert_not @user.save
  end

  test 'should not save record if email is already exist' do
    @user.email = users(:user_one).email
    assert_not @user.save
  end

  test 'should not save record if password is nil' do
    @user.password = nil
    assert_not @user.save
  end

  test 'should not save record if email value is other than email format' do
    @user.email = 'hello'
    assert_not @user.save
  end

  test 'should not save record if password and password confirmation not same' do
    password = 'Password01'
    @user.password = password
    @user.password_confirmation = password.upcase
    assert_not @user.save
  end

  test 'should not save record if password length is lesser than 8 characters' do
    password = 5.times.map { |_c| 'a' }.join('')
    @user.password = password
    @user.password_confirmation = password
    assert_not @user.save
  end

  test 'should not save record if password length is greater than 32 characters' do
    password = 35.times.map { |_c| 'a' }.join('')
    @user.password = password
    @user.password_confirmation = password
    assert_not @user.save
  end

  test 'should not save record if password doen\'t have number' do
    password = 10.times.map { |_c| 'a#' }.join('')
    @user.password = password
    @user.password_confirmation = password
    assert_not @user.save
  end

  test 'should not save record if password doen\'t have special character' do
    password = 5.times.map { |_c| 'a1' }.join('')
    @user.password = password
    @user.password_confirmation = password
    assert_not @user.save
  end

  test 'should not save record if password doen\'t have alphabet' do
    password = 5.times.map { |_c| '#1' }.join('')
    @user.password = password
    @user.password_confirmation = password
    assert_not @user.save
  end
end
