require 'helper'

class TestCreatePhonecallTask < Test::Unit::TestCase
  context 'create a phonecall task' do
    setup do
      @valid_parameters = Scale.hash instruction: "Call this person and tell me his email address. Ask if he's happy too.",
                                     phone_number: '5055006865',
                                     entity_name: 'Alexandr Wang',
                                     fields: { email: 'Email Address' },
                                     script: 'Hello ! Are you happy today? (pause) One more thing - what is your email address?',
                                     choices: ['He is happy', 'He is not happy']

      @invalid_parameters = Scale.hash instruction: 'Test instruction',
                                       phone_number: '5055006865'
    end

    should 'create a valid phone call task' do
      VCR.use_cassette 'tasks' do
        task = scale.create_phonecall_task @valid_parameters
        assert_equal task.class, Scale::Resources::Task
        assert_equal task.params, @valid_parameters.select { |k| %Q(phone_number entity_name fields choices script).include? k.to_s }
      end
    end

    should 'raise a 400 (bad request) error with invalid parameters' do
      VCR.use_cassette 'tasks' do
        assert_raise Scale::HttpError do
          scale.create_phonecall_task @invalid_parameters
        end

        begin
          scale.create_phonecall_task @invalid_parameters
        rescue => e
          exception = e
        end

        assert_equal exception.code, 400
        assert_equal exception.message, 'Please provide an entity name (name, business name, etc.) corresponding to the phone number for the worker.'
      end
    end
  end
end
