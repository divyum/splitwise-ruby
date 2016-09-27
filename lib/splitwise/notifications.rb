require "splitwise/client"

module Splitwise
	class Notifications
		class << self

			def request
				Splitwise::Request.new
			end

			def get_notifications
				params = "get_notifications"
				request.fetch(params)
			end

		end
	end
end
