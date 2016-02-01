deploy_root_dir = File.expand_path("../../../../", __FILE__)

worker_processes 2
listen      "#{deploy_root_dir}/current/tmp/sockets/unicorn.sock"
pid         "#{deploy_root_dir}/current/tmp/pids/unicorn.pid"
stderr_path "#{deploy_root_dir}/current/log/unicorn_stderr.log"
stdout_path "#{deploy_root_dir}/current/log/unicorn_stdout.log"
timeout 1200

# graceful restart
before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end


after_fork do |_server, _worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
