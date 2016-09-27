require "splitwise/client"

module Splitwise
	class Groups
		class << self

			def request
				Splitwise::Request.new
			end

			def list_groups
				params = "get_groups"
				request.fetch(params, )
			end

			def group_info(id)
				params = "get_group/" + id
				request.fetch(params, )
			end

			def create(data)
				params = "create_group"
				request.update(params, data)
			end

			def delete(id)
				params = "delete_group/" + id
				request.update(params, nil)
			end

			def add_user(data)
				params = "add_user_to_group"
				request.update(params, data)
			end

			def remove_user(data)
				params = "remove_user_from_group"
				request.update(params, data)
			end

		end
	end
end
