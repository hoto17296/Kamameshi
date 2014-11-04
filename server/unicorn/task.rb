namespace :unicorn do
  pid = '/tmp/unicorn-kamameshi.pid'
  config = "#{Rails.root}/../server/unicorn/config.rb"

  desc 'Start unicorn server'
  task :start => :environment do
    `unicorn_rails -c #{config} -E production -D`
  end

  desc 'Stop unicorn server gracefully'
  task :stop => :environment do
    `kill -s QUIT $(< #{pid})`
  end

  desc 'Restart unicorn server gracefully'
  task :restart => :environment do
    if File.file? pid
      `kill -s USR2 $(< #{pid})`
    else
      invoke 'unicorn:start'
    end
  end

  desc 'Stop unicorn server immediately'
  task :force_stop => :environment do
    `kill $(< #{pid})`
  end
end
