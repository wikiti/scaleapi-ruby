require 'helper'

class TestListTasks < Test::Unit::TestCase
  context 'list available tasks' do
    should 'retrieve a list of tasks' do
      VCR.use_cassette 'tasks' do
        tasks = scale.list_tasks
        assert_equal(tasks.class, Array)
        assert(tasks.count > 0)
        assert tasks.all? { |t| t.is_a? Scale::Resources::Task }
      end
    end
  end
end
