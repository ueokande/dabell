# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'dabell'
set :repo_url, 'git@dn-talk.naist.jp:dormnet/dabell.git'

set :use_sudo, false

set :pty, true
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{.env}
set :bundle_path, -> { shared_path.join("vendor/bundle") }

set :rvm_ruby_string, "ruby-2.3.0"
set :default_env, { path: "$HOME/.rvm/gems/ruby-2.3.0/bin:$PATH", rvm_bin_path: "~/.rvm/bin" }

set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      with rails_env: fetch(:rails_env) do
        invoke "unicorn:restart"
      end
    end
  end

  after :publishing, :restart

  desc "Create db"
  task :create_db do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, "db:create"
        end
      end
    end
  end

  before :migrate, :create_db
end

namespace :unicorn do
  task :environment do
    set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
    set :unicorn_config, "#{current_path}/config/unicorn/#{fetch(:rails_env)}.rb"
  end

  def start_unicorn
    within current_path do
      execute :bundle, :exec, :unicorn, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
    end
  end

  def stop_unicorn
    execute :kill, "-s QUIT $(< #{fetch(:unicorn_pid)})"
  end

  def reload_unicorn
    execute :kill, "-s USR2 $(< #{fetch(:unicorn_pid)})"
  end

  def force_stop_unicorn
    execute :kill, "$(< #{fetch(:unicorn_pid)})"
  end

  desc "Start unicorn server"
  task :start => :environment do
    on roles(:app) do
      start_unicorn
    end
  end

  desc "Stop unicorn server gracefully"
  task :stop => :environment do
    on roles(:app) do
      stop_unicorn
    end
  end

  desc "Restart unicorn server gracefully"
  task :restart => :environment do
    on roles(:app) do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        reload_unicorn
      else
        start_unicorn
      end
    end
  end

  desc "Stop unicorn server immediately"
  task :force_stop => :environment do
    on roles(:app) do
      force_stop_unicorn
    end
  end
end
