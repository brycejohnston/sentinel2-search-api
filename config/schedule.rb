env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
set :output, "#{path}/log/cron.log"
set :bundle_command, "/home/deploy/.rbenv/shims/bundle"

job_type :rake, "cd :path && :environment_variable=:environment /home/deploy/.rbenv/shims/bundle exec /home/deploy/.rbenv/shims/rake  :task --silent :output"

every 1.day, :at => '2:00 am' do
  rake "aws_import_yesterday"
end

every 1.day, :at => '6:00 am' do
  rake "aws_import_today"
end

every 1.day, :at => '12:00 pm' do
  rake "aws_import_today"
end

every 1.day, :at => '3:00 pm' do
  rake "aws_import_yesterday"
end

every 1.day, :at => '6:00 pm' do
  rake "aws_import_today"
end

every 1.day, :at => '9:00 pm' do
  rake "aws_import_yesterday"
end

every 1.day, :at => '11:00 pm' do
  rake "aws_import_today"
end
