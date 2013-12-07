require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  
  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.infer_base_class_for_anonymous_controllers = false
    config.include Capybara::DSL
    config.use_transactional_fixtures = false
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    Capybara.javascript_driver = :selenium
    Capybara.default_wait_time = 20

    config.before(:each) do
      DatabaseCleaner.start
    end
    
    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  FactoryGirl.reload
end