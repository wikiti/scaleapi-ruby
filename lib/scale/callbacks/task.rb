module Scale
  module Callbacks
    class Task < Base
      attr_reader :task

      def initialize(json)
        super
        build_task
      end

      def self.shortcut
        'task'
      end

      private

      def build_task
        task_data = json[:task].merge task_id: json[:task_id]
        @task = Scale::Resources::Task.new task_data
      end
    end
  end
end
