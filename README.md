# Splitwise Ruby Gem

> A Ruby gem for the [Splitwise](https://www.splitwise.com/index) [API](http://dev.splitwise.com/).


## Installation

Add this line to your application's Gemfile:

    gem 'splitwise'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install splitwise


## Configuration
follow [this](http://dev.splitwise.com/) to get required key and secret
```ruby
require 'splitwise'

SPLITWISE_KEY = <YOUR_CONSUMER_KEY> 
SPLITWISE_SECRET = <YOUR_CONSUMER_SECRET>
Splitwise.access_token = access_token 
```
here `access_token` is access token obtained after authenticating app by user, more about it below.

## [Usage](http://dev.splitwise.com/)
> All data returned will be in string format. Do JSON.parse(response) to convert it to json.

- ###  API Methods   

   - [currencies](http://dev.splitwise.com/dokuwiki/doku.php?id=get_currencies)   
     
     ```ruby
     Splitwise::Request.new.fetch("get_currencies")
     ```   
  - [get_categories](http://dev.splitwise.com/dokuwiki/doku.php?id=get_categories)  

    ```ruby   
    Splitwise::Request.new.fetch("get_categories")
    ```

- ### Users
  - [get_current_user](http://dev.splitwise.com/dokuwiki/doku.php?id=get_current_user)   
    
    ```ruby
    Splitwise::Users.get_current_user
    ```
  - [get_user](http://dev.splitwise.com/dokuwiki/doku.php?id=get_user)
    
    ```ruby
    Splitwise::Users.user_info(id) 
    # 'id' of user who shares a group or a friendship with current user
    ```
  - [update_user_info](http://dev.splitwise.com/dokuwiki/doku.php?id=update_user)
    
    ```ruby
    Splitwise::Users.update_user(id, data)
    # id - current_user_id or user_id of invited user who has not logged in yet
    # data - Hash of Parameters
    ```
    - **Parameters:**
      - first_name, last_name, email, password, locale, date_format, default_currency, default_group_id, notification_settings
      - Eg: 
       
        ```ruby
        id = 123
        data = { 'first_name' => 'first', 'last_name' => 'last', ... }
        Splitwise::Users.update_user(id, data)
        ```
    - **Note:**
        1. A user can update anything about himself.
        2. For other users (for users who is acquainted with but haven’t logged in yet) only [first_name, last_name, email] can be updated.


- ### Groups
  - [list_groups](http://dev.splitwise.com/dokuwiki/doku.php?id=get_groups) : list all groups of current user
    
    ```ruby
    Splitwise::Groups.list_groups
    ```
  - [group_info](http://dev.splitwise.com/dokuwiki/doku.php?id=get_group) : get group info of group_id
    
    ```ruby
    Splitwise::Groups.group_info(group_id)
    ```
  - [create](http://dev.splitwise.com/dokuwiki/doku.php?id=create_group) : create group

    ```ruby
    Splitwise::Groups.create(data)
    # data - Hash of Parameters
    ```
    - **Parameters:** 
        - name (mandatory), group_type (optional), country_code (optional),
        - a list of group members (optional)
            1. users__ARRAYINDEX__PARAMNAME,
            2. params are either: (first_name, last_name, email) or (user_id)
    
  - [delete](http://dev.splitwise.com/dokuwiki/doku.php?id=delete_group): delete group
  
     ```ruby
    Splitwise::Groups.delete(group_id)
    # Returns: {:success ⇒ true/false}
    ```

  - [add_user_to_group](http://dev.splitwise.com/dokuwiki/doku.php?id=add_user_to_group): add a user to existing group

     ```ruby
    Splitwise::Groups.add_user(data)
    # data - Hash of Parameters
    # Return: {:success ⇒ true/false, :errors ⇒ [any errors]}
    ```
    - **Parameters:**
        - group_id and user_id, or
        - group_id, first_name, last_name, email 
(should send an invite if successful and account does not already exist)
    
  - [remove_user_from_group](http://dev.splitwise.com/dokuwiki/doku.php?id=remove_user_from_group): remove user from an existing group
  
    ```ruby
    Splitwise::Groups.remove_user(data)
    # data - Hash of Parameters (group_id, user_id)
    # Return: {:success ⇒ true/false, :errors ⇒ [any errors]}
    ```


- ### Expenses

    - [list_all_expenses](http://dev.splitwise.com/dokuwiki/doku.php?id=get_expenses) : get all your expenses

     ```ruby
     Splitwise::Expenses.list_all_expenses
     ```
    
    - [expense_info](http://dev.splitwise.com/dokuwiki/doku.php?id=get_expense): get expense info of expense_id
    
      ```ruby
      Splitwise::Expenses.expense_info(expense_id)
      ```

    - [create_expense](http://dev.splitwise.com/dokuwiki/doku.php?id=create_expense): create a new expense
    
      ```ruby
      Splitwise::Expenses.create(data)
      # data - Hash of Parameters
      ```

      - **Parameters:**
        - payment, cost, description
        - refer [this](http://dev.splitwise.com/dokuwiki/doku.php?id=create_expense) for more info
        
    - [update_expense](http://dev.splitwise.com/dokuwiki/doku.php?id=update_expense): update an expense
      
      ```ruby
      Splitwise::Expenses.update_expense(expense_id, data)
      # data - Hash of Parameters
      ```
     
    - [delete_expense](http://dev.splitwise.com/dokuwiki/doku.php?id=delete_expense): delete given expense
    
      ```ruby
      Splitwise::Expenses.delete(expense_id)
      ```
    

- ### Friends

    - [list_friends](http://dev.splitwise.com/dokuwiki/doku.php?id=friends): list all friends of user
    
      ```ruby
      Splitwise::Friends.list_friends
      ```
    
    - [friend_info](http://dev.splitwise.com/dokuwiki/doku.php?id=get_friends): get friend infformation
      
       ```ruby
      Splitwise::Friends.friend_info(friend_id)
      ```
    
    - [create_friend](http://dev.splitwise.com/dokuwiki/doku.php?id=create_friend): create a new friend
      
      ```ruby
      Splitwise::Friends.create(data)
      # data - Hash of Parameters
      ```
    
    - [delete_friend](http://dev.splitwise.com/dokuwiki/doku.php?id=delete_friend): delete a friend
      
      ```ruby
      Splitwise::Friends.unfriend(friend_id)
      ```
    
## Usage guideline to integrate with Ruby on Rails / Sinatra app

Splitwise uses OAuth 1.0 for authenticating user which means it needs one time authorization from user. Read more about it [here](https://blog.splitwise.com/2013/07/15/setting-up-oauth-for-the-splitwise-api/).

I have made a sample Sinatra app as a demo of API usage. Refer [example](example).   
I am using [omniauth-splitwise](https://github.com/smudge/omniauth-splitwise) for authentication Splitwise API.

How to run it:

1. `cd example`
2. `bundle`
3. Enter `SPLITWISE_KEY` and `SPLITWISE_SECRET` in the **example_splitwise_api.rb**
4. `ruby example_splitwise_api.rb`
5. Goto [localhost:3000](localhost:3000), you will be directed to authorization page.
6. Once authorized, you can use the api.

## Contributing

1. Fork it ( https://github.com/divyum/splitwise/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
