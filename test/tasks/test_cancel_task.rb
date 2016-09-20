require 'helper'

class TestCancelTask < Test::Unit::TestCase
  context 'cancel a completed task' do
    should 'raise an error' do
      VCR.use_cassette 'tasks' do
        # First, create a task
        task = scale.create_phonecall_task instruction: "Call this person and tell me his email address. Ask if he's happy too.",
                                           phone_number: '5055006865',
                                           entity_name: 'Alexandr Wang',
                                           fields: { email: 'Email Address' },
                                           choices: ['He is happy', 'He is not happy']

        # Then, try canceling it
        assert_raise Scale::HttpError do
          scale.cancel_task task_id: task.id
        end
      end
    end
  end
end
