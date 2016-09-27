require "splitwise/client"

module Splitwise
  class Expenses
    class << self

      def request
        Splitwise::Request.new
      end

      def list_all_expenses
        params = "get_expenses"
        request.fetch(params, accessor_token)
      end

      def expense_info(id)
        params = "get_expense/" + id
        request.fetch(params)
      end

      def create(data)
        params = "create_expense"
        request.update(params, data)
      end

      def update(id, data)
        params = "update_expense/" + id
        request.update(params, data)
      end

      def delete(id)
        params = "delete_expense/" + id
        request.update(params, data)
      end

    end
  end
end
