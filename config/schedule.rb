## Cron job list
ENV.each_key do |key|
  env key.to_sym, ENV[key]
end
set :environment, ENV["RAILS_ENV"]

# Computing TestInstances status hash every 10minutes, using rake task
every 2.minute do
  rake 'update:test_instances_status_hash'
end

# Computing TestInstances with no examiners every days, using rake task
every :day do
  rake 'update:test_instances_with_no_examiners'
end

# Usefull commands

# bundle exec whenever --clear-crontab  # Cleaning whenever cron jobs

# bundle exec whenever --update-crontab --set environment='development' # Updating crontab jobs and setting environment
# bundle exec crontab -l   # Listing job on crontab

# grep CRON  /var/log/syslog  # Greping Crontab logs
