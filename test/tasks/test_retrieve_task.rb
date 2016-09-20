require 'helper'

class TestRetrieveTask < Test::Unit::TestCase
  context 'retrieve an available tasks' do
    should 'return a task object' do
      VCR.use_cassette 'tasks' do
        # First, create a task
        task1 = scale.create_phonecall_task instruction: "Call this person and tell me his email address. Ask if he's happy too.",
                                            phone_number: '5055006865',
                                            entity_name: 'Alexandr Wang',
                                            fields: { email: 'Email Address' },
                                            choices: ['He is happy', 'He is not happy']

        # Retrieve that task, and compare it with the previous task
        task2 = scale.retrieve_task task_id: task1.id
        assert_equal(task1.id, task2.id)
        assert_equal(task1.instruction, task2.instruction)
        assert_equal(task1.callback_url, task2.callback_url)
        assert_equal(task1.created_at, task2.created_at)
      end
    end
  end

  context 'retrieve a non existent tasks' do
    setup do
      @fake_task_id = 'abcdefghijklmn0123456789'
    end

    should 'raise an http error' do
      VCR.use_cassette 'tasks' do
        assert_raise Scale::HttpError do
          scale.retrieve_task task_id: @fake_task_id
        end
      end
    end
  end
end
