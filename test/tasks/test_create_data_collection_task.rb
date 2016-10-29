require 'helper'

class TestCreateDataCollectionTask < Test::Unit::TestCase
  context 'create a comparison task' do
    setup do
      @valid_parameters = Scale.hash callback_url: 'http://www.example.com/callback',
                                     instruction: 'Find the URL for the hiring page for the company with attached website.',
                                     attachment_type: 'website',
                                     attachment: 'https://www.scaleapi.com/',
                                     fields: { hiring_page: 'Hiring Page URL' }

      @invalid_parameters = Scale.hash instruction: 'Test instruction',
                                       fields: { hiring_page: 'Hiring Page URL' }
    end

    should 'create a valid data collection task' do
      VCR.use_cassette 'tasks' do
        task = scale.create_data_collection_task @valid_parameters
        assert_equal task.class, Scale::Resources::Task
        assert_equal task.params, @valid_parameters.select { |k| %Q(fields attachments attachment_type).include? k.to_s }
      end
    end

    should 'raise a 400 (bad request) error with invalid parameters' do
      VCR.use_cassette 'tasks' do
        assert_raise Scale::HttpError do
          scale.create_data_collection_task @invalid_parameters
        end

        begin
          scale.create_data_collection_task @invalid_parameters
        rescue => e
          exception = e
        end

        assert_equal exception.code, 400
        assert_equal exception.message, 'Invalid attachment_type - please choose one of these: text website'
      end
    end
  end
end
