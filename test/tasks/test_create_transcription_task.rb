require 'helper'

class TestCreateTranscriptionTask < Test::Unit::TestCase
  context 'create a categorization task' do
    setup do
      @valid_parameters = Scale.hash instruction: 'Transcribe the given fields. Then for each news item on the page, transcribe the information for the row.',
                                     attachment_type: 'website',
                                     attachment: 'http://www.google.com/',
                                     fields: { title: 'Title of Webpage', top_result: 'Title of the top result' },
                                     row_fields: { username: 'Username of submitter', comment_count: 'Number of comments' }

      @invalid_parameters = Scale.hash instruction: 'Test instruction',
                                       attachment_type: 'website'
    end

    should 'create a valid transcription task' do
      VCR.use_cassette 'tasks' do
        task = scale.create_transcription_task @valid_parameters
        assert_equal task.class, Scale::Resources::Task
        assert_equal task.params, @valid_parameters.select { |k| %Q(attachment_type attachment fields row_fields).include? k.to_s }
      end
    end

    should 'raise a 400 (bad request) error with invalid parameters' do
      VCR.use_cassette 'tasks' do
        assert_raise Scale::HttpError do
          scale.create_transcription_task @invalid_parameters
        end

        begin
          scale.create_transcription_task @invalid_parameters
        rescue => e
          exception = e
        end

        assert_equal exception.code, 400
        assert_equal exception.message, 'Please provide an attachment as a URL or plaintext.'
      end
    end
  end
end
