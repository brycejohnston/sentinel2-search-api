env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
set :output, "#{path}/log/cron.log"
set :bundle_command, "/home/deploy/.rbenv/shims/bundle"

job_type :rake, "cd :path && :environment_variable=:environment /home/deploy/.rbenv/shims/bundle exec /home/deploy/.rbenv/shims/rake  :task --silent :output"
