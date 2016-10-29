module Scale
  module Resources
    class Tasks < Array
      include Base

      ATTRIBUTES = %w(docs total limit offset has_more)
      ATTRIBUTES.each { |attr| attr_reader attr }

      def initialize(tasks, attributes = {})
        ATTRIBUTES.each do |attr|
          instance_variable_set "@#{attr}", attributes[attr]
        end

        super tasks
      end
    end
  end
end
