Feature: Running paperclip in a Rails app using basic Google Storage support

  Scenario: Basic utilization
    Given I have a rails application
    And I save the following as "app/models/user.rb"
    """
    class User < ActiveRecord::Base
    has_attached_file :avatar,
                      :storage => :googlestorage,
                      :path => "/:attachment/:id/:style/:filename",
                      :bucket => 'apraditya-paperclip'
                      :google_storage_credentials => Rails.root.join("config/google_storage.yml")
    end
    """
    And I validate my Google Storage credentials
    And I save the following as "config/google_storage.yml"
    """
    access_key_id: <%= ENV['GS_ACCESS_KEY_ID'] %>
    secret_access_key: <%= ENV['GS_SECRET_ACCESS_KEY'] %>
    """
    When I visit /users/new
    And I fill in "user_name" with "something"
    And I attach the file "test/fixtures/5k.png" to "user_avatar"
    And I press "Submit"
    Then I should see "Name: something"
    And I should see an image with a path of "http://apraditya-paperclip.commondatastorage.googleapis.com/avatars/1/original/5k.png"
    And the file at "http://apraditya-paperclip.commondatastorage.googleapis.com/avatars/1/original/5k.png" is the same as "test/fixtures/5k.png"
