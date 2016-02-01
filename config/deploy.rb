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
