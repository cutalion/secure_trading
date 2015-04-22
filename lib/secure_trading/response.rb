class SecureTrading::Response
  attr_reader :body, :raw

  def initialize(body)
    @raw  = body
    @body = Nokogiri::XML(body)
  end

  def success?
    error_code && error_code.content == "0"
  end

  def request_reference
    body.at_css('requestreference').content
  end

  def error_code
    body.at_css('error code')
  end

  def error_message
    message = body.at_css('error message').content
    message = "#{message} (#{error_data})" if error_data
    message
  end

  def error_data
    data = body.at_css('error data')
    data && data.content
  end
end
