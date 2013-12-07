source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '3.2.14'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "font-awesome-rails"
end

gem 'jquery-rails'
gem 'bootstrap-sass', '>= 3.0.0.0'
gem 'figaro'
gem 'pg'
gem 'thin'
gem 'flickraw'
gem 'kaminari'

group :development do
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'better_errors'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'selenium-webdriver'
  gem 'spork', '~> 0.9.2'
end
