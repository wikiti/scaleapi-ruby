[![Gem Version](https://badge.fury.io/rb/scaleapi-ruby.svg)](https://badge.fury.io/rb/scaleapi-ruby) [![Dependency Status](https://gemnasium.com/badges/github.com/wikiti/scaleapi-ruby.svg)](https://gemnasium.com/github.com/wikiti/scaleapi-ruby) [![CircleCI](https://circleci.com/gh/wikiti/scaleapi-ruby.svg?style=shield)](https://circleci.com/gh/wikiti/scaleapi-ruby)

# ScaleAPI for Ruby

A simple ruby wrapper for the [Scale](http://www.scaleapi.com) HTTP API. Documentation for this API is available [here](https://docs.scaleapi.com/).

This project uses [`juwelier`](https://github.com/flajann2/juwelier) for managing and releasing this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scaleapi-ruby'
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install scaleapi-ruby
```

## Usage

First, you need to initialize the Scale client:

```ruby
require 'scale'
scale = Scale.setup api_key: 'YOUR_KEY_GOES_HERE',              # Required
                    callback_key: 'YOUR CALLBACK_KEY_GOES_HERE' # Optional
```

Check [this]() for further information.

### Tasks

Most of these methods will return a `Scale::Resources::Task` object, which will contain information
about the json response (task_id, status...).

Any parameter available in the [documentation](https://docs.scaleapi.com) can be passed as an argument
option with the corresponding type.

The following endpoints for tasks are available:

#### Create categorization task

Check [this](https://docs.scaleapi.com/#create-categorization-task) for further information.

```ruby
task = scale.create_categorization_task(
  callback_url: 'http://www.example.com/callback',
  instruction: 'Is this company public or private?',
  attachment_type: 'website',
  attachment: 'http://www.google.com/',
  categories: ['public', 'private']
)
```

#### Create transcription task

Check [this](https://docs.scaleapi.com/#create-transcription-task) for further information.

```ruby
task = scale.create_transcription_task(
  callback_url: 'http://www.example.com/callback',
  instruction: 'Transcribe the given fields. Then for each news item on the page, transcribe the information for the row.',
  attachment_type: 'website',
  attachment: 'http://www.google.com/',
  fields: { title: 'Title of Webpage', top_result: 'Title of the top result' },
  row_fields: { username: 'Username of submitter', comment_count: 'Number of comments' }
)
```

#### Create phone call task

Check [this](https://docs.scaleapi.com/#create-phone-call-task) for further information.

```ruby
scale.create_phonecall_task(
  callback_url: 'http://www.example.com/callback',
  instruction: "Call this person and tell me his email address. Ask if he's happy too.",
  phone_number: '5055006865',
  entity_name: 'Alexandr Wang',
  script: 'Hello ! Are you happy today? (pause) One more thing - what is your email address?',
  fields: { email: 'Email Address' },
  choices: ['He is happy', 'He is not happy']
)
```

#### Create comparison task

Check [this](https://docs.scaleapi.com/#create-comparison-task) for further information.

```ruby
scale.create_comparison_task(
  callback_url: 'http://www.example.com/callback',
  instruction: 'Do the objects in these images have the same pattern?',
  attachment_type: 'image',
  choices: ['yes', 'no'],
  attachments: [
    'http://i.ebayimg.com/00/$T2eC16dHJGwFFZKjy5ZjBRfNyMC4Ig~~_32.JPG',
    'http://images.wisegeek.com/checkered-tablecloth.jpg'
  ]
)
```

#### Create annotation task

Check [this](https://docs.scaleapi.com/#create-annotation-task-bounding-box) for further information.

```ruby
scale.create_annotation_task(
  callback_url: 'http://www.example.com/callback',
  instruction: 'Draw a box around each baby cow and big cow.',
  attachment_type: "image",
  attachment: "http://i.imgur.com/v4cBreD.jpg",
  objects_to_annotate: ["baby cow", "big cow"],
  examples: [
    {
      correct: false,
      image: 'http://i.imgur.com/lj6e98s.jpg',
      explanation: 'The boxes are tight and accurate'
    },
    {
      correct: true,
      image: 'http://i.imgur.com/HIrvIDq.jpg',
      explanation: 'The boxes are neither accurate nor complete'
    }
  ]
)
```

#### Create data collection task

Check [this](https://docs.scaleapi.com/?shell#create-data-collection-task) for further information.

```ruby
scale.create_data_collection_task(
  callback_url: 'http://www.example.com/callback',
  instruction: 'Find the URL for the hiring page for the company with attached website.',
  attachment_type: 'website',
  attachment: 'https://www.scaleapi.com/',
  fields: {
    hiring_page: 'Hiring Page URL'
  }
)
```

#### Retrieve task

Check [this](https://docs.scaleapi.com/#retrieve-a-task) for further information.

Retrieve a task given its id.

```ruby
task = scale.retrieve_task 'asdfasdfasdfasdfasdfasdf'
task.id == 'asdfasdfasdfasdfasdfasdf' # true
```

#### Cancel task

Check [this](https://docs.scaleapi.com/#cancel-a-task) for further information.

Cancel a task given its id, only if it's not completed.

```ruby
task = scale.cancel_task 'asdfasdfasdfasdfasdfasdf'
```

#### List tasks

Check [this](https://docs.scaleapi.com/#list-all-tasks) for further information.

Retrieve a list (`Array`) of all tasks.

```ruby
tasks = scale.tasks # Scale::Resources::Tasks
tasks.all? { |t| t.is_a? Scale::Resources::Task } # true
```

### Callbacks

This gem allows you to create and parse callback data, so it can be easily used for web applications:

For example, for Ruby on Rails:

```ruby
# app/controllers/scale_api_controller.rb
class ScaleApiController < ApplicationController
  # POST /scale_api
  def create
    callback = scale.build_callback params, 'task', callback_key: request.headers['scale-callback-auth']
    callback.response # Response content hash (code and result)
    callback.task     # Scale::Resources::Task object
  end
end
```

Please note that callback validation is optional; omit it if no `callback_key` was passed to `Scale.build`
builder.

If the validation is enabled, the `build_callback` method will raise a `Scale::GenericError`, explaning that
the tokens don't match. You can also use `valid_callback_key?` to test it:

```rb
# `scale.callback_key` is 'TEST'
scale.valid_callback_key? 'FAKE' # false, because 'TEST' != 'FAKE'
```

## Error handling

If something went wrong while making API calls, then exceptions will be raised automatically
as a `Scale::GenericError` (or `Scale::HttpError`) runtime error. For example:

```ruby
begin
  scale.create_categorization_task instructions: 'Some parameters are missing.'
rescue Scale::HttpError => e
  puts e.code # 400
  puts e.exception # Missing parameter X
  pust e.original_exception # Catched exception
rescue Scale::GenericError => e
  puts e.message # Missing parameter X
end
```

## Custom options

The api initialization accepts the following options:

| Name | Description | Default |
| ---- | ----------- | ------- |
| `endpoint` | Endpoint used in the http requests. | `'https://api.scaleapi.com/v1/'` |
| `api_key` | API key used in the http requests. | `nil` |
| `callback_key` | API key used to validate callback POST requests. | `nil` |
| `default_request_params` | Default parameters (payload) for the API requests | `{}` |

For example, `default_request_params` can be used to always set the same `callback_url` value:

```rb
scale = Scale.setup api_key: 'YOUR_KEY_GOES_HERE',              # Required
                    callback_key: 'YOUR CALLBACK_KEY_GOES_HERE' # Optional
                    default_request_params: {
                      callback_url: 'http://www.example.com/callback'
                    }

# All callback requests will posted be made to http://www.example.com/callback
scale.create_comparison_task(
  instruction: 'Draw a box around each baby cow and big cow.',
  attachment_type: "image",
  attachment: "http://i.imgur.com/v4cBreD.jpg",
  objects_to_annotate: ["baby cow", "big cow"]
)
```

## Authors

This project has been developed by:

| Avatar | Name | Nickname | Email |
| ------- | ------------- | --------- | ------------------ |
| ![](http://www.gravatar.com/avatar/2ae6d81e0605177ba9e17b19f54e6b6c.jpg?s=64)  | Daniel Herzog | Wikiti | [wikiti.doghound@gmail.com](mailto:wikiti.doghound@gmail.com) |
