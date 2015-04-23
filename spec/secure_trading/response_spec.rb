require_relative "../spec_helper"

describe SecureTrading::Response do
  describe "when error code is 0" do
    it "should be successful" do
      xml = "
      <responseblock>
        <response>
          <error>
            <code>0</code>
          </error>
        </response>
      </responseblock>"

      response = SecureTrading::Response.new(xml)
      response.success?.must_equal true
    end
  end

  describe "when error code is 1" do
    it "should not be successful" do
      xml = "
      <responseblock>
        <response>
          <error>
            <code>1</code>
          </error>
        </response>
      </responseblock>"

      response = SecureTrading::Response.new(xml)
      response.success?.must_equal false
    end
  end

  describe "#error_message" do
    it "should return content of //error/message element" do
      xml = "
      <responseblock>
        <response>
          <error>
            <message>Ok</message>
          </error>
        </response>
      </responseblock>"

      response = SecureTrading::Response.new(xml)
      response.error_message.must_equal 'Ok'
    end

    describe "when error has additional data" do
      it "should add it to message" do
        xml = "
        <responseblock>
          <response>
            <error>
              <message>Invalid field</message>
              <data>billingpostcode</data>
            </error>
          </response>
        </responseblock>"

        response = SecureTrading::Response.new(xml)
        response.error_message.must_equal 'Invalid field (billingpostcode)'
      end
    end
  end

  describe "#request_reference" do
    include Fixtures

    it "should return request reference from the response" do
      response = SecureTrading::Response.new(good_response_xml)
      response.request_reference.must_equal 'W4-paxj67xr'
    end
  end

  describe "#transaction_reference" do
    include Fixtures

    it "should return transaction reference from the response" do
      response = SecureTrading::Response.new(good_response_xml)
      response.transaction_reference.must_equal '4-9-2053545'
    end
  end
end
