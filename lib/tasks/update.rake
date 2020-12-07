# frozen_string_literal: true

namespace :update do
  desc 'Computing TestInstances status hash'
  task test_instances_status_hash: :environment do
    # Reminder: Using batches could be better there
    TestInstance.all.each(&:update_hash)
  end

  desc 'Computing TestInstances with no examiners'
  task test_instances_with_no_examiners: :environment do
    # A bit tricky, removing all test instance witch got examiners from all test instance
    # So we got only those which got no examiners
    (TestInstance.all - TestInstance.left_joins(:users).where(users: { role: 2 })).each(&:assign_examiner)
  end
end
