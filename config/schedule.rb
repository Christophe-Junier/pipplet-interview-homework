## Cron job list

# Env settings
ENV.each_key do |key|
  env key.to_sym, ENV[key]
end
set :environment, ENV["RAILS_ENV"]

# Computing TestInstances status hash every 10 minutes, using rake task
every 10.minute do
  rake 'update:test_instances_status_hash'
end

# Computing TestInstances with no examiners every days, using rake task
every :day do
  rake 'update:test_instances_with_no_examiners'
end

# Usefull commands

# bundle exec whenever --clear-crontab  # Cleaning whenever cron jobs

# bundle exec whenever --update-crontab # Updating crontab jobs and setting environment
# bundle exec crontab -l   # Listing job on crontab
