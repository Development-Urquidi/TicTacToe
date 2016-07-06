# require 'require_all'
# require_relative './lib/'

require_relative './lib/concerns/helpers'
require_relative './lib/engine'
require_relative './lib/board'
require_relative './lib/player'

engine = Engine.new
engine.start