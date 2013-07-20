require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "userOne inserted correctly" do
     users = User.all.select{|t| t.email == 'test@test.com'}
     assert users.length == 1

   end
end
