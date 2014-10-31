namespace :unicorn do
  unicorn_pid = "/tmp/pids/unicorn-kamameshi.pid"
  unicorn_config = "#{Rails.root}/../server/unicorn/config.rb"

  def start_unicorn
    within current_path do
      execute :unicorn_rails, "-c #{config} -E production -D"
    end
  end

  def stop_unicorn
    execute :kill, "-s QUIT $(< #{pid})"
  end

  def reload_unicorn
    execute :kill, "-s USR2 $(< #{pid})"
  end

  def force_stop_unicorn
    execute :kill, "$(< #{pid})"
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
    if test("[ -f #{pid} ]")
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
