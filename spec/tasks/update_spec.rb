# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

describe 'test_instances_status_hash' do
  let(:test_instance) { create(:test_instance, :en) }

  it 'update test_instances status hash' do
    test_instance

    expect(TestInstance.first.status_hash).to eq(nil)
    run_task(task_name: 'test_instances_status_hash')
    expect(TestInstance.first.status_hash).to_not eq(nil)
  end
end

describe 'test_instances_with_no_examiners' do
  let(:test_instance) { create(:test_instance, :en) }
  let(:examiner)      { create(:user, :examiner, :examiner_validated, :examiner_en) }

  it 'try to assign examiners to test instances with no examiners' do
    test_instance
    @examiner = examiner

    expect(test_instance.users.count).to eq(0)
    run_task(task_name: 'test_instances_with_no_examiners')
    expect(test_instance.users.count).to eq(1)
    expect(test_instance.users.first).to eq(@examiner)
  end
end

def run_task(task_name:)
  Rake::Task["update:#{task_name}"].invoke
end
