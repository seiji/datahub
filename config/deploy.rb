require "bundler/capistrano"
require 'capistrano_colors'
require "whenever/capistrano"

# init
set :whenever_command, "bundle exec whenever"
set :application, "datahub"

# user
set :user, "deploy"
set :group, user
set :runner, user
set :use_sudo,false
set(:run_method) { use_sudo ? :sudo : :run }

# scm
set :repository, "git://github.com/seiji/datahub.git"
set :scm, :git
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :branch, "master"

# strategy
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :current_path, "#{deploy_to}/current"
set :shared_path, "#{deploy_to}/shared"
set :normalize_asset_timestamps, false

# role
set :host, "data"
role :web, host
role :app, host
role :db, host, :primary => true

set :whenever_roles, :db

namespace :deploy do
  task :restart do
  end

  task :start do
  end

  task :stop do
  end

  task :setup_config, roles: :app do
  end
  after "deploy:setup", "deploy:setup_config"
  after 'deploy:update', 'whenever:update_crontab'  
end
