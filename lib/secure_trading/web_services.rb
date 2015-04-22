class SecureTrading::WebServices
  def auth(params)
    payment = SecureTrading::Payment.new(params)
    request = SecureTrading::AuthRequest.new(payment: payment)
    request.run
  end
end
