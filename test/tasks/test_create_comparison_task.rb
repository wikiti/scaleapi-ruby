require 'helper'

class TestCreateAnnotationTask < Test::Unit::TestCase
  context 'create a comparison task' do
    setup do
      @valid_parameters = Scale.hash instruction: 'Do the objects in these images have the same pattern?',
                                     attachment_type: 'image',
                                     choices: ['yes', 'no'],
                                     attachments: [
                                       'http://i.ebayimg.com/00/$T2eC16dHJGwFFZKjy5ZjBRfNyMC4Ig~~_32.JPG',
                                       'http://images.wisegeek.com/checkered-tablecloth.jpg'
                                     ]

      @invalid_parameters = Scale.hash instruction: 'Test instruction',
                                       choices: ['a', 'b']
    end

    should 'create a valid comparison task' do
      VCR.use_cassette 'tasks' do
        task = scale.create_comparison_task @valid_parameters
        assert_equal task.class, Scale::Resources::Task
        assert_equal task.params, @valid_parameters.select { |k| %Q(attachment_type choices attachments).include? k.to_s }
      end
    end

    should 'raise a 400 (bad request) error with invalid parameters' do
      VCR.use_cassette 'tasks' do
        assert_raise Scale::HttpError do
          scale.create_comparison_task @invalid_parameters
        end

        begin
          scale.create_comparison_task @invalid_parameters
        rescue => e
          exception = e
        end

        assert_equal exception.code, 400
        assert_equal exception.message, 'Please provide attachments for the worker to compare for the task.'
      end
    end
  end
end
