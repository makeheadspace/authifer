require './test/helpers/default'
require './test/helpers/dotenv'
require './test/helpers/database'

require 'capybara'

Capybara.app = Authifer::App

Authifer::App.get "/" do
  if logged_in?
    "Logged in as: #{current_user.email}"
  else
    "Not logged in"
  end
end

class AppTest < DatabaseTest
  User = Authifer::User
  include Capybara::DSL

  def login(user_attributes)
    visit "/sessions/new"
    within "#login_form" do
      fill_in "user[email]", with: user_attributes.fetch(:email, "")
      fill_in "user[password]", with: user_attributes.fetch(:password, "")
      click_on "Log in"
    end
  end

  def register(user_attributes)
    visit '/users/new'
    within "#registration_form" do
      fill_in "user[email]", with: user_attributes.fetch(:email, "")
      fill_in "user[password]", with: user_attributes.fetch(:password, "")
      fill_in "user[password_confirmation]", with: user_attributes.fetch(:password_confirmation, "")
      click_on "Register"
    end
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

