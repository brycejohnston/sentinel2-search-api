task :aws_import_yesterday => :environment do
  SentinelWorker.perform_async(Date.yesterday.strftime("%Y-%m-%d"))
end

task :aws_import_today => :environment do
  SentinelWorker.perform_async(Date.today.strftime("%Y-%m-%d"))
end
