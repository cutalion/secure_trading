require_relative 'spec_helper'

describe SecureTrading do
  describe 'configuration' do
    after do
      SecureTrading.configuration = SecureTrading::Configuration.new
    end

    it "should have an API URL" do
      SecureTrading.configure do |c| c.api_url = "API_URL" end
      SecureTrading.configuration.api_url.must_equal 'API_URL'
    end

    it "should have login" do
      SecureTrading.configure do |c| c.login = 'LOGIN' end
      SecureTrading.configuration.login.must_equal 'LOGIN'
    end

    it "should have password" do
      SecureTrading.configure do |c| c.password = 'PASS' end
      SecureTrading.configuration.password.must_equal 'PASS'
    end

    it "should have site reference" do
      SecureTrading.configure do |c| c.site_reference = 'SITE_REF' end
      SecureTrading.configuration.site_reference.must_equal 'SITE_REF'
    end

    it "should have http client version" do
      SecureTrading.configure do |c| c.http_client_version = 'CLIENT_VER' end
      SecureTrading.configuration.http_client_version.must_equal 'CLIENT_VER'
    end

    describe 'defaults' do
      let(:config) { SecureTrading.configuration }

      it "has http_client_version" do
        config.http_client_version.must_equal 'Ruby SecureTrading client 0.1a'
      end

      it "has api_url" do
        config.api_url.must_equal "https://webservices.securetrading.net:443/xml/"
      end
    end
  end
end
