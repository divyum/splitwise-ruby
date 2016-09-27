require "splitwise/client"

module Splitwise
  class Users
    class << self

      def request
        Splitwise::Request.new
      end

      def get_current_user
        params = "get_current_user"
        request.fetch(params)
      end

      def user_info(id)
        params = "get_user/" + id
        request.fetch(params)
      end

      def update_user(id, data)
        params = "update_user/" + id
        request.update(params, data)
      end

    end
  end
end
