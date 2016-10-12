source "https://rubygems.org"

ruby "2.3.1"

gem "active_model_serializers", "~> 0.10.0"
gem "bcrypt", "~> 3.1.7"
gem "delayed_job_active_record"
gem "jwt"
gem "pg", "~> 0.18"
gem "puma", "~> 3.0"
gem "rack-cors"
gem "rails", "~> 5.0.0", ">= 5.0.0.1"
gem "versionist"
gem "warden"

group :development, :test do
  gem "bullet"
  gem "dotenv-rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.5"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "coveralls", require: false
  gem "factory_girl_rails"
  gem "email_spec"
  gem "shoulda-matchers"
  gem "webmock"
end
