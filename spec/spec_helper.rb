require 'dotenv'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'

Dotenv.load

require_relative '../lib/secure_trading'
require_relative 'support/fixtures'
