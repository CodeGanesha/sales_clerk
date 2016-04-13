source 'https://rubygems.org'

# extensions, reporting, printing (all depend on office_clerk)
gem 'accountant_clerk' , github: "rubyclerks/accountant_clerk"
#gem 'accountant_clerk' , path: "../accountant_clerk"

gem 'print_clerk' , github: "rubyclerks/print_clerk"
#gem 'print_clerk' , path: "../print_clerk"

gem 'barby' , github: "rubyclerks/barby"

gem "stripe_clerk", github: "rubyclerks/stripe_clerk"
#gem 'stripe_clerk' , path: "../stripe_clerk"

gem 'post_clerk' ,  github: "rubyclerks/post_clerk"

gem "office_clerk", github: "rubyclerks/office_clerk"
#gem "office_clerk", path: "../office_clerk"

gem 'db_fixtures_dump'  , github: "dancinglightning/db_fixtures_dump" #backup

gem 'sqlite3'
gem "rails"
gem 'rails-i18n'

#one wishes one would not need it. alas . . .
gem 'rack-attack'

# error collection
gem 'rollbar'

group :development do
  gem 'better_errors' , :platforms=>[:mri_20, :mri_21, :rbx]
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :mri_21,:rbx]
  gem "i18n-tasks"
  gem 'quiet_assets'
  gem "thin"
  gem "rb-readline"
end

group  :production do
  gem "therubyracer"
  gem "libv8"
  gem 'uglifier'
  gem "newrelic_rpm"
  gem "mysql2" , "~> 0.3.13"
end

group :test do
#  gem "poltergeist"
#  gem "phantomjs"
  gem "codeclimate-test-reporter"
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem "factory_girl_rails"
  gem 'i18n-spec'
  gem "email_spec"
  gem 'guard'
  gem 'guard-rspec'
end
