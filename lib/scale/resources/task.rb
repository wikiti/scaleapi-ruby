module Scale
  module Resources
    class Task
      ATTRIBUTES = %w(task_id type instruction params urgency response callback_url status created_at completed_at)

      attr_reader *ATTRIBUTES

      def initialize(json)
        ATTRIBUTES.each do |attr|
          instance_variable_set "@#{attr}", json[attr]
        end

        tweak_attributes
      end

      protected

      def tweak_attributes
        @created_at = DateTime.parse(created_at) if created_at != ''
        @completed_at = DateTime.parse(completed_at) if completed_at != ''
      end
    end
  end
end
