## Cron job list
# IMPORTANT! Using rbenv with ruby build cause path issue, defining path solve this.
env :PATH, ENV['PATH']

# Computing TestInstances status hash every 20minutes, using rake task
every 20.minute do
  rake 'update:test_instances_status_hash'
end

# Computing TestInstances with no examiners every days, using rake task
every :day do
  rake 'update:test_instances_with_no_examiners'
end
