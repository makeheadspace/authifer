# Authifer

`Trust me Authifer, I'm not half as think as you drunk I am!`

One obstacles to chiseling away a monolithic application architecture is
managing user authentication on several smaller apps.

Authifer abstracts authentication into it's own application so you can focus
your attention on adding useful features for your customers instead of managing
user identities.

## Usage

A fully working implementation of authifer is Make Headspaces [Auth
website](http://authn.makeheadspace.com) -
[source](https://github.com/makeheadspace/authn.makeheadspace.com)

Feel free to reference the code for inspiration.


```ruby
require 'sinatra'

Authifer.configure do |config|
  config.database_url = sqlite3://db/auth_provder.sqlite3'
end

use Authifer::App

helpers do
  include Authifer::AuthenticationHelper
  include Authifer::Paths
end

get '/' do
  if logged_in?
    "<a href='#{ delete_session_path }'>log out</a>"
  else
    "<a href='#{ new_session_path }'>log in</a>" +
    " or " +
    "<a href='#{ new_user_path }'>register</a>"
  end
end
```

### Custom Views
Set the Authifer.views\_path  in your configure block.

```ruby
Authifer.configure do |config|
  config.views_path = File.join(File.path(File.expand_path(__FILE__)),'views', 'authifer')
  config.database_url = 'sqlite3://db/auth_provder.sqlite3'
end

```

Check out these [sample views](./lib/authifer/views).

## Contributing

We love pull requests and issues!

### For enhancements

Create an issue or pull request with:

1. A good name
2. Tests where applicable

### For bug fixes

Create an issue with:

1. Reproduction steps
2. Stack trace if applicable
3. Proposed fix if applicable
