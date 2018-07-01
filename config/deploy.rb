# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "curriculum"
# set :repo_url, "git@example.com:me/my_repo.git"
set :repo_url, "git@github.com:21pstem/curriculum.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_files, "config/database.yml", "app/assets/images/logo.png"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :default_environment, {
  # 'PATH' => "/path/to/.rvm/gems/ree/1.8.7/bin:/path/to/.rvm/bin:/path/to/.rvm/ree-1.8.7-2009.10/bin:$PATH",
  # 'RUBY_VERSION' => 'ruby 1.8.7'
  # 'GEM_HOME'     => '/path/to/.rvm/gems/ree-1.8.7-2010.01',
  # 'GEM_PATH'     => '/path/to/.rvm/gems/ree-1.8.7-2010.01',
  # 'BUNDLE_PATH'  => '/path/to/.rvm/gems/ree-1.8.7-2010.01'  # If you are using bundler.
}
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  # custom hooks into the deploy lifecycle
  before :starting, 'check_write_permissions'
  # before :updating, 'db:backup'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :cleanup, :restart

end
