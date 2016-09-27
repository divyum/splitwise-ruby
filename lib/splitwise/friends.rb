require "splitwise/client"

module Splitwise
	class Friends
		class << self

			def request
				Splitwise::Request.new
			end

			def list_friends
				params = "get_friends"
				request.fetch(params)
			end

			def friend_info(id)
				params = "get_friend/" + id
				request.fetch(params)
			end

			def create(data)
				params = "create_friend"
				request.update(params, data)
			end

			def create_friends
				# to do
			end

			def unfriend(id)
				params = "delete_friend/" + id
				request.update(params, nil)
			end

		end
	end
end
