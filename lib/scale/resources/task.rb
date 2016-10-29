module Scale
  module Resources
    class Task
      include Base

      ATTRIBUTES = %w(task_id type instruction params urgency response callback_url status created_at completed_at)
      ATTRIBUTES.each { |attr| attr_reader attr }

      alias_method :id, :task_id

      def initialize(json = {})

        ATTRIBUTES.each do |attr|
          instance_variable_set "@#{attr}", json[attr]
        end

        tweak_attributes
      end

      protected

      def tweak_attributes
        @created_at = Time.parse(created_at) rescue nil
        @completed_at = Time.parse(completed_at) rescue nil
        @params = Scale.hash(params)
      end
    end
  end
end
