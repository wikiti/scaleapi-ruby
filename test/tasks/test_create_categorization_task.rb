require 'helper'

class TestCreateCategorizationTask < Test::Unit::TestCase
  context 'create a categorization task' do
    setup do
      @valid_parameters = Scale.hash instruction: 'Is this company public or private?',
                                     attachment_type: 'website',
                                     attachment: 'http://www.google.com/',
                                     categories: ['public', 'private'],
                                     allow_multiple: false

      @invalid_parameters = Scale.hash instruction: 'Test instruction'
    end

    should 'create a valid categorization task' do
      VCR.use_cassette 'tasks' do
        task = scale.create_categorization_task @valid_parameters
        assert_equal task.class, Scale::Resources::Task
        assert_equal task.params, @valid_parameters.select { |k| %Q(attachment_type attachment categories allow_multiple).include? k.to_s }
      end
    end

    should 'raise a 400 (bad request) error with invalid parameters' do
      VCR.use_cassette 'tasks' do
        assert_raise Scale::HttpError do
          scale.create_categorization_task @invalid_parameters
        end

        begin
          scale.create_categorization_task @invalid_parameters
        rescue => e
          exception = e
        end

        assert_equal exception.code, 400
        assert_equal exception.message, 'Please provide an attachment as a URL or plaintext.'
      end
    end
  end
end
