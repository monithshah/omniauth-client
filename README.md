# Omniauth Elitmus

[![Build Status](https://travis-ci.org/elitmus/omniauth-elitmus.svg?branch=master)](https://travis-ci.org/elitmus/omniauth-elitmus)

[![Code Climate](https://codeclimate.com/github/elitmus/omniauth-elitmus/badges/gpa.svg)](https://codeclimate.com/github/elitmus/omniauth-elitmus)

[![Test Coverage](https://codeclimate.com/github/elitmus/omniauth-elitmus/badges/coverage.svg)](https://codeclimate.com/github/elitmus/omniauth-elitmus)

[![Gem Version](https://badge.fury.io/rb/omniauth-elitmus.svg)](http://badge.fury.io/rb/omniauth-elitmus)

## eLitmus OAuth2 Strategy for OmniAuth

This is official OmniAuth strategy for authenticating to eLitmus.com. To use it, you'll need to register your consumer application on elitmus.com to get pair of OAuth2 Application ID and Secret.   It supports the OAuth 2.0 server-side and client-side flows for 3rd party OAuth consumer applications 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-elitmus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-elitmus

## Usage

OmniAuth::Strategies::Elitmus is simply a Rack middleware.

 First, register your application at 'www.elitmus.com/oauth/applications' with valid callback url to get app_id and secret (elitmus.com uses callback url to redirect to your app). Create environement variables 'ELITMUS_KEY', 'ELITMUS_SECRET' to store your app_id, secret respectively. Here's a quick example, adding the middleware to a Rails app in config/initializers/omniauth.rb.


```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET']
end
```

## Configuration

You can configure several options, which you can pass in to the `provider` method via a `Hash`. also refer 'Examples' section accordingly.

Option name | Default | Explanation
--- | --- | ---
`scope` | `public` | lets you set scope to provide granular access to different types of data. If not provided, scope defaults to 'public' for users. you can use any one of "write", "public" and "admin" values for scope.
`auth_type` | nil | Optionally specifies the requested authentication feature. Valid value is 'reauthenticate' (asks the user to re-authenticate unconditionally). If not specified, default value is nil. (reuses the existing session of last authenticated user if any).
`callback_path` | '/auth/:provider/callback' | Specify a custom callback URL used during the server-side flow. Note this must be same as specified at the time of your applicaiton registration at www.elitmus.com/oauth/applications. Execution flow returns back to this point at consumer application after authencitcation flow finishes at server-side. If not specified, default is '/auth/:provider/callback'. Make an entry for this end point in config/routes.rb of your consumer application. Strategy automatically replaces ':provider' by provider name as specified in config/initializers/omniauth.rb.

### Examples 

#### scope

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], { :scope => "admin" }
end
```
If not specified, default scope is 'public'

#### auth_type

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], 
  		{ :scope => "admin", :authorize_params => { :auth_type => "reauthenticate" }}
end
```
If not specified, default is nil.

#### callback_path

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elitmus, ENV['ELITMUS_KEY'], ENV['ELITMUS_SECRET'], 
      { :scope => "admin", :authorize_params => { :auth_type => "reauthenticate" }, 
        :callback_path => '/your/custom/callback/path'}
end
```
If not specified, default callback_path is '/auth/:provider/callback'.Here, finally it would be '/auth/elitmus/callback' as per explained in configuration table.

## Auth Hash

Here's an example *Auth Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'elitmus',
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

1. Fork it ( https://github.com/[my-github-username]/omniauth-elitmus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
