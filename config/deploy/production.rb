set :stage, :production
set :rails_env, :production

set :branch, "deploy_with_capistrano"

set :user, "dabell"
set :deploy_to, "/home/dabell/dabell"

role :app, %w{dn-talk.naist.jp}
role :web, %w{dn-talk.naist.jp}
role :db, %w{dn-talk.naist.jp}

server "dn-talk.naist.jp", user: "dabell", roles: %i(app web db)
