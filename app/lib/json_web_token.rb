class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp=Time.now+1.day)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET, true, { :algorithm => 'HS256' })[0]
    HashWithIndifferentAccess.new body
  end
end
