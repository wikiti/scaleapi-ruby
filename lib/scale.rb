require 'uri'
require 'time'
require 'rest-client'
require 'json'

require 'active_support/core_ext/hash/indifferent_access'

require 'scale/api'
require 'scale/generic_error'
require 'scale/http_error'

require 'scale/resources/base'
require 'scale/resources/task'

require 'scale/endpoints/endpoint'

require 'scale/endpoints/tasks/task_endpoint'
require 'scale/endpoints/tasks/create_annotation_task'
require 'scale/endpoints/tasks/create_categorization_task'
require 'scale/endpoints/tasks/create_transcription_task'
require 'scale/endpoints/tasks/create_comparison_task'
require 'scale/endpoints/tasks/create_phonecall_task'
require 'scale/endpoints/tasks/retrieve_task'
require 'scale/endpoints/tasks/cancel_task'
require 'scale/endpoints/tasks/list_tasks'

require 'scale/callbacks/base'
require 'scale/callbacks/task'

module Scale
  def self.setup(params = {})
    Scale::API.new params
  end

  def self.hash(data = nil)
    ActiveSupport::HashWithIndifferentAccess.new data
  end

  def self.descendants(klass)
    ObjectSpace.each_object(::Class).select {|d| d < klass }
  end
end
