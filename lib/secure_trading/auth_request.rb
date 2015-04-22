class SecureTrading::AuthRequest
  include Virtus.model

  attribute :payment, SecureTrading::Payment

  def run
    response = client.post(api_url, body, headers)
    SecureTrading::Response.new response.body
  end

  def body
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.requestblock(version: payment.api_version) {
        xml.alias_ config.login
        xml.request(type: payment.request_type) {
          xml.operation {
            xml.sitereference               config.site_reference
            xml.accounttypedescription      payment.account_type_description
            xml.authmethod                  payment.auth_method
            xml.parenttransactionreference  payment.parent_transaction_ref
          }

          xml.merchant {
            xml.orderreference payment.merchant_order_reference
            xml.email          payment.merchant_email
          }

          xml.billing {
            xml.premise    payment.billing_premise
            xml.street     payment.billing_street
            xml.town       payment.billing_town
            xml.county     payment.billing_county
            xml.country    payment.billing_country_code
            xml.postcode   payment.billing_postcode
            xml.email      payment.billing_email
            xml.telephone  payment.billing_phone, type: payment.billing_phone_type

            xml.name {
              xml.prefix   payment.billing_name_prefix
              xml.first    payment.billing_name_first
              xml.middle   payment.billing_name_middle
              xml.last     payment.billing_name_last
              xml.suffix   payment.billing_name_suffix
            }

            xml.amount  payment.amount, currencycode: payment.currency_code

            xml.payment(type: payment.card_type) {
              xml.expirydate    payment.card_expiry_date
              xml.pan           payment.card_number
              xml.securitycode  payment.card_security_code
            }
          }

          xml.customer {
            xml.premise    payment.customer_premise
            xml.street     payment.customer_street
            xml.town       payment.customer_town
            xml.county     payment.customer_county
            xml.country    payment.customer_country_code
            xml.postcode   payment.customer_postcode
            xml.email      payment.customer_email
            xml.telephone  payment.customer_phone, type: payment.customer_phone_type

            xml.name {
              xml.prefix   payment.customer_name_prefix
              xml.first    payment.customer_name_first
              xml.middle   payment.customer_name_middle
              xml.last     payment.customer_name_last
              xml.suffix   payment.customer_name_suffix
            }
          }

          xml.settlement {
            xml.settleduedate  payment.settle_due_date
            xml.settle_status  payment.settle_status
          }
        }
      }
    end

    builder.to_xml
  end



  private

  def config
    SecureTrading.configuration
  end

  def headers
    {
      'Content-Type'  => 'text/xml;charset=utf8',
      'Accept'        => 'text/xml',
      'User-Agent'    => version,
      'Authorization' => "Basic #{auth}",
      'Connection'    => 'close',
    }
  end

  def login
    config.login
  end

  def password
    config.password
  end

  def auth
    Base64.strict_encode64 "#{login}:#{password}"
  end

  def version
    config.http_client_version
  end

  def site_reference
    config.site_reference
  end

  def api_url
    config.api_url
  end

  def client
    HTTPClient.new
  end

end
