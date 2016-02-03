
deploy_root_dir = File.expand_path("../../../", __FILE__)
bind     "unix://#{deploy_root_dir}/tmp/sockets/puma.sock"
pidfile "#{deploy_root_dir}/tmp/pids/puma.pid"
stdout_redirect "#{deploy_root_dir}/log/unicorn_stdout.log",
                "#{deploy_root_dir}/log/unicorn_stderr.log"
