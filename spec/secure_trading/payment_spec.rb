require_relative "../spec_helper"

describe SecureTrading::Payment do
  describe "#initialize" do
    it "should raise an exception if unknown attributes passed" do
      -> { SecureTrading::Payment.new unknown_attribute: 1 }.
        must_raise SecureTrading::Payment::UnknownAttributes
    end

    it "should set known attributes" do
      payment = SecureTrading::Payment.new(amount: 1000)
      payment.amount.must_equal 1000
    end
  end
end
