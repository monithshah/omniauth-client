# Omniauth Client


## Generic Client OAuth2 Strategy for OmniAuth

This is Generic OmniAuth strategy to authenticate with multiple clients under same provider name with dynamic configurations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-client

## Usage

OmniAuth::Strategies::Client is simply a Rack middleware.


```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :client, ENV['CLIENT_KEY'], ENV['CLIENT_SECRET'], :client_options => { :site => CLIENT_OPTIONS['site'] }, :api_path => CLIENT_OPTIONS['api_path']
end
```

## Configuration

You can configure several options, which you can pass in to the `provider` method via a `Hash`. also refer 'Examples' section accordingly.

Option name | Default | Explanation
--- | --- | ---
`scope` | `public` | lets you set scope to provide granular access to different types of data. If not provided, scope defaults to 'public' for users. you can use any one of "write", "public" and "admin" values for scope.
`auth_type` | nil | Optionally specifies the requested authentication feature. Valid value is 'reauthenticate' (asks the user to re-authenticate unconditionally). If not specified, default value is nil. (reuses the existing session of last authenticated user if any).
`callback_path` | '/auth/client/callback' | Provider has been fixed as client hence this cannot be modified
`api_path` | nil | This is the path which the gem is going to hit on client server to extract User data

### Examples

#### api_path

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elitmus, ENV['CLIENT_KEY'], ENV['CLIENT_SECRET'],
      { :scope => "admin", :authorize_params => { :auth_type => "reauthenticate" },
        :api_path => '/api/v1/user_info' }
end
```

## Auth Hash

Here's an example *Auth Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'client',
  :uid => '98979695',
  :info => {
    :email => 'kishoredaa@evergreen.com',
    :name => 'Kishore Kumar'
  },
  :credentials => {
    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
    :expires_at => 1321747205, # when the access token expires (it always will)
    :expires => true # this will always be true
  },
  :extra => {
    :raw_info => {
      :id => '98979695',
      :channel => 'Through a friend',
      :email => 'kishoredaa@evergreen.com',
      :name => 'Kishore Kumar'
      :email_lower => 'kishoredaa@evergreen.com',
      :first_login => 'Y',
      :registered_on => '2012-01-17T00:37:29+05:30',
      :source_campus => '0',
      :status => 'active'
    }
  }
}
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/omniauth-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
