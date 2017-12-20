source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

gem 'activerecord-postgis-adapter', '~> 5.0'

gem 'active_model_serializers', '~> 0.10'
gem 'rack-cors', :require => 'rack/cors'

gem 'sentinel2_aws'

# background jobs
gem 'redis', '~> 3.3'
gem 'sidekiq', '< 6'

# scheduled cron jobs
gem 'whenever', '0.9.7', :require => false

# deployment
gem 'mina', '1.0.7'
gem 'mina-sidekiq', '1.0.2'
gem 'mina-whenever'

group :development, :test do
  gem 'byebug'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
