require "neovim/buffer"
require "neovim/client"
require "neovim/current"
require "neovim/cursor"
require "neovim/object"
require "neovim/option"
require "neovim/rpc"
require "neovim/scope"
require "neovim/tabpage"
require "neovim/variable"
require "neovim/version"
require "neovim/window"

module Neovim
  InvalidAddress = Class.new(ArgumentError)

  def self.connect(address, port=nil)
    if port
      Client.new TCPSocket.new(address, port)
    else
      Client.new UNIXSocket.new(address)
    end
  rescue => e
    raise InvalidAddress, e.message
  end
end
