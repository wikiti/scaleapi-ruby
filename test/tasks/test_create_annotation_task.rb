require 'helper'

class TestCreateAnnotationTask < Test::Unit::TestCase
  context 'create a annotation task' do
    setup do
      @valid_parameters = Scale.hash instruction: 'Draw a box around each baby cow and big cow.',
                                     attachment_type: "image",
                                     attachment: "http://i.imgur.com/v4cBreD.jpg",
                                     objects_to_annotate: ["baby cow", "big cow"],
                                     with_labels: true,
                                     examples: [
                                       { correct: false, image: 'http://i.imgur.com/lj6e98s.jpg', explanation: 'The boxes are tight and accurate' },
                                       { correct: true, image: 'http://i.imgur.com/HIrvIDq.jpg', explanation: 'The boxes are neither accurate nor complete' }
                                     ]

      @invalid_parameters = Scale.hash
    end

    should 'create a valid annotation task' do
      VCR.use_cassette 'tasks' do
        task = scale.create_annotation_task @valid_parameters
        assert_equal task.class, Scale::Resources::Task
        assert_equal task.params, @valid_parameters.select { |k| %Q(attachment_type attachment explanation objects_to_annotate examples with_labels).include? k.to_s }
      end
    end

    should 'raise a 400 (bad request) error with invalid parameters' do
      VCR.use_cassette 'tasks' do
        assert_raise Scale::HttpError do
          scale.create_annotation_task @invalid_parameters
        end

        begin
          scale.create_annotation_task @invalid_parameters
        rescue => e
          exception = e
        end

        assert_equal exception.code, 400
        assert_equal exception.message, 'Please provide an attachment as a URL or plaintext.'
      end
    end
  end
end
