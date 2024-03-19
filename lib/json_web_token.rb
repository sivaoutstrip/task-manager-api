# frozen_string_literal: true

class JsonWebToken
  class << self
    HMAC_SECRET = Rails.application.credentials.secret_key_base

    def generate(id = nil)
      JWT.encode(exp_payload(id), HMAC_SECRET, 'HS256')
    end

    def decode(token)
      return false if token.nil?

      JWT.decode(token, HMAC_SECRET).dig(0, 'data')
    rescue JWT::ExpiredSignature,
           JWT::DecodeError
      nil
    end

    def exp_payload(id)
      exp = (Time.now + 1.day).to_i
      { data: id, exp: }
    end
  end
end
