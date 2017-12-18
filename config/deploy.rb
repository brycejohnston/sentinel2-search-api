require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/whenever'
require 'mina_sidekiq/tasks'

set :domain, 'sentinel2.cropquest.net'
set :deploy_to, '/home/deploy/sentinel2-search-api'
set :repository, 'git@github.com:CropQuest/sentinel2-search-api'
set :branch, 'master'
set :user, 'deploy'
set :port, '2012'
set :forward_agent, true

# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push('log', 'pids')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# This task is the environment that is loaded all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0}
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'sidekiq:quiet'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'whenever:update'
      invoke :'sidekiq:restart'
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end
end
