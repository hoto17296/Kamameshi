namespace :unicorn do
  task :environment do
    set :unicorn_pid, "/tmp/pids/unicorn-kamameshi.pid"
    set :unicorn_config, "#{Rails.root}/../server/unicorn/config.rb"
  end

  def start_unicorn
    within current_path do
      execute :unicorn_rails, "-c #{fetch(:unicorn_config)} -E production -D"
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
    start_unicorn
  end

  desc "Stop unicorn server gracefully"
  task :stop => :environment do
    stop_unicorn
  end

  desc "Restart unicorn server gracefully"
  task :restart => :environment do
    if test("[ -f #{fetch(:unicorn_pid)} ]")
      reload_unicorn
    else
      start_unicorn
    end
  end

  desc "Stop unicorn server immediately"
  task :force_stop => :environment do
    force_stop_unicorn
  end
end
