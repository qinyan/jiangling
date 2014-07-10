
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)
# production and test server use different configuration
case ENV['server']
when 'production'
  set :domain, '10.10.10.80'
  set :port, '60777'     # SSH port number.
  set :user, 'tanf'    # Username in the server to SSH to.
  set :deploy_to, '/home/tanf/yginfo'
  set :repository, 'git@10.20.30.14:cms/yginfo.git'
  set :branch, 'master'
  set :term_mode, :system # solve the termina vs zsh conflict
  set :keep_releases, 5
  set :rvm_path, '/usr/local/rvm/bin/rvm'
  task :environment do
    invoke :'rvm:use[ruby-1.9.3-p448@default]'
  end
when 'tangl'
  set :domain, '192.168.0.211'
  set :user, 'tangl'    # Username in the server to SSH to.
  set :deploy_to, '/Users/tangl/mina'
  set :repository, 'git@github.com:qinyan/jiangling.git'
  set :branch, 'master'
  set :term_mode, :system # solve the termina vs zsh conflict
  set :keep_releases, 5
  # set :rvm_path, '/usr/local/rvm/bin/rvm'
  task :environment do
    invoke :'rvm:use[ruby-1.9.3-p547@rails3.13]'
  end
else
  set :domain, '192.168.211.244'
  set :user, 'root'    # Username in the server to SSH to.
  set :deploy_to, '/usr/ror/yginfo'
  set :repository, 'git@10.20.30.14:cms/yginfo.git'
  set :branch, 'develop'
  set :term_mode, :system # solve the termina vs zsh conflict
  set :keep_releases, 5
  set :rvm_path, '/usr/local/rvm/bin/rvm'
  task :environment do
    invoke :'rvm:use[ruby-1.9.3-p448@default]'
  end
end

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
# this will link the file to relative floder
# set :shared_paths, ['config/database.yml','config/thin.yml','config/config.yml','config/mongoid.yml', 'log', 'tmp/pids']
set :shared_paths, ['config/database.yml', 'log']
# Optional settings:
  # set :port, '30000'     # SSH port number.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
# task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
#   invoke :'rvm:use[ruby-1.9.3-p545@default]'
# end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue! "bundle exec thin -C config/thin.yml stop"
      queue! "bundle exec thin -C config/thin.yml start"
    end
  end
end

# after "deploy:symlink", "deploy:update_crontab"  
  
# namespace :deploy do  
#   desc "Update the crontab file"  
#   task :update_crontab, :roles => :db do  
#     run "cd #{release_path} && whenever --update-crontab #{application}"  
#   end  
# end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers



