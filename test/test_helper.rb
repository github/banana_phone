require 'rubygems'
require "minitest/autorun"
require "minitest/should"
require 'mocha'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'banana_phone'

class Enc
  include BananaPhone::Encodes
end