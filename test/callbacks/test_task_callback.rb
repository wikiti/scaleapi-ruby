require 'helper'

class TestTaskCallback < Test::Unit::TestCase
  context 'process json data' do
    setup do
      @json_data = load_json('callback.json')
      @callback = scale.build_callback @json_data, 'task', callback_key: 'TEST'
    end

    should 'create a valid response' do
      VCR.use_cassette 'tasks' do
        assert_equal @callback.response, @json_data[:response]
      end
    end

    should 'create a valid task' do
      VCR.use_cassette 'tasks' do
        assert_equal @callback.task.id, @json_data[:task_id]
        assert_equal @callback.task.status, @json_data[:task][:status]
      end
    end
  end

  context 'invalid callback key' do
    setup do
      @json_data = load_json('callback.json')
    end

    should 'raise an error' do
      assert_raise Scale::GenericError do
        scale.build_callback @json_data, 'task', callback_key: 'FAKE'
      end
    end
  end
end
