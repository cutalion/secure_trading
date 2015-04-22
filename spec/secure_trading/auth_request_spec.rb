require_relative "../spec_helper"

describe SecureTrading::AuthRequest do
  before do
    SecureTrading.configure do |c|
      c.login          = ENV['LOGIN']
      c.password       = ENV['PASSWORD']
      c.site_reference = ENV['SITE_REFERENCE']
    end
  end


  describe "#body" do
    it "should strip out phone field if no phone or phone type" do
      payment = SecureTrading::Payment.new({
        billing_phone:       '0000 111111',

        customer_phone:      '',
        customer_phone_type: 'H',
      })

      request = SecureTrading::AuthRequest.new(payment: payment)
      Nokogiri::XML(request.body).at_css('billing telephone').must_be_nil
      Nokogiri::XML(request.body).at_css('customer telephone').must_be_nil
    end

    it "should include phones if all phone fields passed" do

      payment = SecureTrading::Payment.new({
        billing_phone:        '0000 111111',
        billing_phone_type:   'M',

        customer_phone:       '0000 111111',
        customer_phone_type:  'H',
      })

      request = SecureTrading::AuthRequest.new(payment: payment)
      Nokogiri::XML(request.body).at_css('billing telephone').wont_be_nil
      Nokogiri::XML(request.body).at_css('customer telephone').wont_be_nil
    end
  end
end
