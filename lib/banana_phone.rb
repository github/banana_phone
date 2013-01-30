require 'mochilo'
require 'socket'
require 'net/protocol'

require 'banana_phone/service'
require 'banana_phone/request'
require 'banana_phone/mod'
require 'banana_phone/encodes'
require 'banana_phone/action'
require 'banana_phone/errors'

module BananaPhone
  def self.version
    File.read(File.join(File.dirname(__FILE__), *%w[.. VERSION])).chomp
  rescue
    'unknown'
  end

  VERSION = self.version
end