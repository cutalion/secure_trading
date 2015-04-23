require_relative "../spec_helper"

describe SecureTrading::WebServices do
  before do
    SecureTrading.configure do |c|
      c.login          = ENV['LOGIN']
      c.password       = ENV['PASSWORD']
      c.site_reference = ENV['SITE_REFERENCE']
    end
  end

  let(:good_params) { {
    merchant_order_reference: "Example AUTH",
    amount:                   2115,
    currency_code:            'GBP',
    card_type:                'VISA',
    card_expiry_date:         '10/2031',
    card_number:              '4111111111111111',
    card_security_code:       '123',

    billing_name_first:       'John',
    billing_name_last:        'Doe',
    billing_street:           'Green st',
    billing_town:             'Bangor',
    billing_country_code:     'GB',
    billing_county:           'Hobbitshire',
    billing_postcode:         'TE45 6ST',
    billing_phone:            '0000 111111',
    billing_phone_type:       'H',
    billing_email:            'customer@example.com',

    customer_name_first:      'John',
    customer_name_last:       'Doe',
    customer_street:          'Green st',
    customer_town:            'Bangor',
    customer_country_code:    'GB',
    customer_county:          'Hobbitshire',
    customer_postcode:        'TE45 6ST',
    customer_phone:           '0000 111111',
    customer_phone_type:      'H',
    customer_email:           'customer@example.com',
  } }

  let(:client) { SecureTrading::WebServices.new }

  it "should work" do
    response = client.auth(good_params)

    response.error_message.must_equal 'Ok'
    response.success?.must_equal true
  end

  describe "with incorrect parameters" do
    it "should not be successful" do
      response = client.auth({})
      response.success?.must_equal false
    end
  end


  describe "declined transaction" do
    it "should not be successful" do
      bad_amount = 70000 # http://www.securetrading.com/files/documentation/STPP-XML-Specification.pdf
      bad_params = good_params.merge(amount: bad_amount)

      response = client.auth(bad_params)
      response.error_message.must_equal 'Decline'
      response.success?.must_equal false
    end
  end
end
