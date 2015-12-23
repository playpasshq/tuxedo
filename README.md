# Tuxedo Decorate
[![Build Status](https://travis-ci.org/playpasshq/tuxedo.svg)](https://travis-ci.org/playpasshq/tuxedo)
[![Code Climate](https://codeclimate.com/github/playpasshq/tuxedo/badges/gpa.svg)](https://codeclimate.com/github/playpasshq/tuxedo)
[![Inline docs](http://inch-ci.org/github/playpasshq/tuxedo.png)](http://inch-ci.org/github/playpasshq/tuxedo)
[![Gem Version](https://badge.fury.io/rb/tuxedo_decorate.svg)](https://badge.fury.io/rb/tuxedo_decorate)

Tuxedo Decorate provides an easy to use `Presenter` layer on top of Rails views.
It does not make any assumptions about your underline object or uses black
magic voodoo code to determine your ActiveRecord Relations.

## Installation

Currently rails 4.0 or higher and ruby version of 2.0.0 or higher are supported.
Add this line to your application's Gemfile:

```ruby
gem 'tuxedo_decorate', require: 'tuxedo'
```

**Notice the require statement!**

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tuxedo_decorate

## Usage

To use Tuxedo simply include it in your presenter class. For example

```ruby
class BananaPresenter
  include Tuxedo

  def name
    'hello'
  end

  def name_with_args(name, surname: '')
    "hello #{name}, #{surname}"
  end
end
```

In your views you can use the `presenter_for` helper to use the presenter.
By default Tuxedo looks for a class with the same name but ending in `Presenter`.
For example, we now use `BananaPresenter`.

```ruby
<% presenter_for(Banana.new) do |present| %>
<span><%= present.name %></span>
<div><%= present.name_with_args('Jan', surname: 'Stevens') %></div>
end
```

### Using the Present-and-Call [PRAC]
A shorthand is also included that allows to easily call a presenter method
for to present object. For example

```ruby
<%= prac(Banana.new, :name) %>
```

This basically translates to the following:

```ruby
<%= presenter_for(Banana.new).name %>
```

Extra arguments are passed along to the presenter method, so the following
also workes

```ruby
<%= prac(Banana.new, :name_with_args, 'Jan', surname: 'Stevens') %>
```

### Example Setup
We have a `presenters` folder in our app folder. In their we have an `ApplicationPresenter`
that defines reusable methods. Every presenter inherits from `ApplicationPresenter`.
For example

```ruby
class ApplicationPresenter
  include Tuxedo

  # Here we setup our typical delegation methods
  delegate(:current_user,
    :link_to,
    :content_tag,
    to: :_h)

  # Bunch of shared methods
  def html_id
    # ...
  end
end

class BananaPresenter < ApplicationPresenter
  def name
    'hello'
  end

  def name_with_args(name, surname: '')
    "hello #{name}, #{surname}"
  end
end
```

## FAQ

### No blocks in the views because [reasons]!
Sure got you covered

```ruby
<% present = presenter_for(Banana.new) %>
<span><%= present.name %></span>
<div><%= present.name_with_args('Jan', surname: 'Stevens') %></div>
```

### But I rather have Presenters that are Decorater classes and are named [obscure name]
Allright you can configure the suffix to be used by using a config block and placing it
somewhere in the Rails initialization chain

```ruby
Tuxedo.configure do |config|
  config.suffix = 'ObscureName'
end
```

### How can I access the original decorated object?
Easily, you can use `object` but thats quite obscure so by default Tuxedo "guesses" (`demodulize` + `gsub` + `underscore`)
the name of your object. For example if my Presenter class is name `BananaPresenter` then
I can access the original object by using `banana`

```ruby
class BananaPresenter
  include Tuxedo

  def greetings
    "hello #{banana.name}"
  end
end
```

If thats not good enough you can overwrite the `object_alias` used. This allows for
using `monkey` instead of `banana`.

```ruby
class BananaPresenter
  include Tuxedo
  object_alias :monkey

  def greetings
    "hello #{monkey.name}"
  end
end
```

### Can I use `prac` inside my Presenters?
Sure you can, for your convenience `prac`` is made available. This allows you to reuse
presenter methods.

```ruby
class BananaPresenter
  def name
    "BANANA BANANA BANANA"
  end
end

class MonkeyPresenter
  def eat
    prac monkey.banana, :name
  end
end
```

### How can I access my view helpers / url helpers / rails helpers
We expose a method `_h` that delegates to the view context. So you have to prefix
all your url helpers with `_h`, for example:

```ruby
class BananaPresenter
  include Tuxedo

  def edit_link
    _h.edit_banana_path(banana)
  end
end
```

### But I don't want to prefix everything with _h
I'ts ruby just use `delegate`, for example in our application we have to following setup

```ruby
class BananaPresenter
  include Tuxedo
  delegate(:current_user,
    :link_to,
    :auth_link_to,
    :auth_service,
    to: :_h)

  def edit_link
    _h.edit_banana_path(banana)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

