# frozen_string_literal: true

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
class User < ApplicationRecord
  has_secure_password

  normalizes :email, with: ->(email) { email.squish.strip.downcase }

  validates :email, presence: true, uniqueness: true, format: { with: %r{\A[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+)*@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\z} }
  validates :password, length: { in: 8..32 },
                       format: { with: /(?=.*[a-zA-Z])(?=.*\d)(?=.*[\W_])/ },
                       if: proc { |a| a.password.present? }
  validates :password_confirmation, presence: true

  has_many :tasks, inverse_of: :user, dependent: :destroy

  def jwt_token
    JsonWebToken.generate(id)
  end
end
