require 'nokogiri'
require 'httpclient'
require 'base64'
require 'virtus'

module SecureTrading
  class Exception < Exception; end

  def self.configure(&block)
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(configuration)
    raise ArgumentError, "must be SecureTrading::Configuration" unless configuration.is_a? SecureTrading::Configuration
    @configuration = configuration
  end

  class Configuration
    attr_accessor :api_url, :login, :password, :site_reference, :http_client_version

    def http_client_version
      @http_client_version || "Ruby SecureTrading client 0.1a"
    end

    def api_url
      @api_url || "https://webservices.securetrading.net:443/xml/"
    end
  end
end

require_relative 'secure_trading/version'
require_relative 'secure_trading/web_services'
require_relative 'secure_trading/payment'
require_relative 'secure_trading/auth_request'
require_relative 'secure_trading/response'
