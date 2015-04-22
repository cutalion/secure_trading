class SecureTrading::Payment
  include Virtus.model

  attribute  :account_type_description, String, default: 'ECOM'
  attribute  :request_type, String, default: 'AUTH'
  attribute  :api_version, String, default: '3.67'

  attribute  :merchant_email, String
  attribute  :merchant_order_reference, String
  attribute  :auth_method, String
  attribute  :parent_transaction_ref, String

  attribute  :billing_premise, String
  attribute  :billing_street, String
  attribute  :billing_town, String
  attribute  :billing_county, String
  attribute  :billing_country_code, String
  attribute  :billing_postcode, String
  attribute  :billing_email, String
  attribute  :billing_phone, String
  attribute  :billing_phone_type, String

  attribute  :billing_name_prefix, String
  attribute  :billing_name_first, String
  attribute  :billing_name_middle, String
  attribute  :billing_name_last, String
  attribute  :billing_name_suffix, String

  attribute  :amount, Integer
  attribute  :currency_code, String

  attribute  :customer_premise, String
  attribute  :customer_street, String
  attribute  :customer_town, String
  attribute  :customer_county, String
  attribute  :customer_country_code, String
  attribute  :customer_postcode, String
  attribute  :customer_email, String
  attribute  :customer_phone, String
  attribute  :customer_phone_type, String
  attribute  :customer_ip, String
  attribute  :customer_forwarded_ip, String

  attribute  :customer_name_prefix, String
  attribute  :customer_name_first, String
  attribute  :customer_name_middle, String
  attribute  :customer_name_last, String
  attribute  :customer_name_suffix, String

  attribute  :card_type, String
  attribute  :card_expiry_date, String
  attribute  :card_number, String
  attribute  :card_security_code, String

  attribute  :settle_due_date, String
  attribute  :settle_status, String
end
