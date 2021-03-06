require 'test_helper'

class RemoteUsaEpayTransactionTest < Test::Unit::TestCase
  def setup
    Base.gateway_mode = :test
    @gateway = UsaEpayTransactionGateway.new(fixtures(:usa_epay))
    @creditcard = credit_card('4000100011112224')
    @declined_card = credit_card('4000300011112220')
    @options = { :billing_address => address }
    @amount = 100
  end

  def test_successful_purchase
    assert response = @gateway.purchase(@amount, @creditcard, @options)
    assert_equal 'Success', response.message
    assert_success response
  end

  def test_unsuccessful_purchase
    assert response = @gateway.purchase(@amount, @declined_card, @options)
    assert_equal 'Card Declined (00)', response.message
    assert_failure response
  end

  def test_authorize_and_capture
    assert auth = @gateway.authorize(@amount, @creditcard, @options)
    assert_success auth
    assert_equal 'Success', auth.message
    assert auth.authorization
    assert capture = @gateway.capture(@amount, auth.authorization)
    assert_success capture
  end

  def test_failed_capture
    assert response = @gateway.capture(@amount, '')
    assert_failure response
    assert_equal 'Unable to find original transaction.', response.message
  end

  def test_successful_refund
    assert response = @gateway.purchase(@amount, @creditcard, @options)
    assert_success response
    assert response.authorization
    assert refund = @gateway.refund(@amount - 20, response.authorization)
    assert_success refund
  end

  def test_unsuccessful_refund
    assert refund = @gateway.refund(@amount - 20, "unknown_authorization")
    assert_failure refund
    assert_match /Unable to find original transaction/, refund.message
  end

  def test_successful_void
    assert response = @gateway.purchase(@amount, @creditcard, @options)
    assert_success response
    assert response.authorization
    assert void = @gateway.void(response.authorization)
    assert_success void
  end

  def test_unsuccessful_void
    assert void = @gateway.void("unknown_authorization")
    assert_failure void
    assert_match /Unable to locate transaction/, void.message
  end

  def test_invalid_key
    gateway = UsaEpayTransactionGateway.new(:login => '')
    assert response = gateway.purchase(@amount, @creditcard, @options)
    assert_equal 'Specified source key not found.', response.message
    assert_failure response
  end
end
