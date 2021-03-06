require "bundler/capistrano"
load "deploy/assets"
set :use_sudo, false

set :application, "sample_app"
set :scm, :git
set :repository,  "git://github.com/bsherman26/sample_app.git"
set :user, "sample_app"
role :web, "basileis.com"                          # Your HTTP server, Apache/etc
role :app, "basileis.com"                          # This may be the same as your `Web` server
role :db,  "basileis.com", :primary => true        # This is where Rails migrations will run
set :deploy_to, "/apps/sample_app"
default_run_options[:pty] = true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
