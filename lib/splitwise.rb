require "splitwise/version"
require "splitwise/constants"
require "splitwise/client"
require "splitwise/users"
require "splitwise/friends"
require "splitwise/groups"
require "splitwise/expenses"
require "splitwise/notifications"


module Splitwise
	class << self
		attr_accessor :access_token
	end
end
