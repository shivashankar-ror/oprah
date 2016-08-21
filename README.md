# Oprah

[![Gem Version](https://badge.fury.io/rb/oprah.svg)](https://badge.fury.io/rb/oprah)
[![Build Status](https://travis-ci.org/endofunky/oprah.svg)](https://travis-ci.org/endofunky/oprah)
[![Code Climate](https://codeclimate.com/github/endofunky/oprah.svg)](https://codeclimate.com/github/endofunky/oprah)
[![Dependency Status](https://gemnasium.com/badges/github.com/endofunky/oprah.svg)](https://gemnasium.com/github.com/endofunky/oprah)

Opinionated presenters for Rails 5 - without the cruft.

## Table of Contents

* [Overview](#overview)
* [Installation](#installation)
* [Getting started](#getting-started)
  + [ActionController integration](#actioncontroller-integration)
* [Collections](#collections)
* [Associations](#associations)
* [Composition](#composition)
  + [Performance](#performance)
  + [Ordering](#ordering)
  + [Choosing presenters](#choosing-presenters)
* [Testing](#testing)
* [License](#license)
* [Author](#author)

## Overview

If you've ever worked on a sufficiently large Rails application you've probably
experienced the Rails helper mess first hand. Helper methods are annoying to
locate, hard to test and not terribly expressive.

So why another presenter/decorator library? Oprah was written with a few simple
goals in mind only covered partially (or not at all) by other gems:

- Lightweight
- Presenters should be easy to test
- Avoid monkey patching, where possible :monkey::gun:
- Embrace convention over configuration
- First-class support for composition (modules and concerns)

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'oprah'
```

And then execute:

```
$ bundle
```

## Getting started

Oprah expects a single presenter for each of your classes or modules. If your
model is called `User` it will look for a class called `UserPresenter`:

``` ruby
class User
  def first_name
    "John"
  end

  def last_name
    "Doe"
  end
end

class UserPresenter < Oprah::Presenter
  def name
    "#{first_name} #{last_name}"
  end
end
```

Oprah will figure out the presenters by itself so you don't have to instantiate
your presenter classes directly:

``` ruby
presenter = Oprah.present(User.new)

presenter.name
# => "John Doe"

```

Of course, all the regular methods on your model are still accessible:

``` ruby
presenter.first_name
# => "John"
```

If you *DO* want to use a specific presenter, you can simply instantiate it
yourself:

``` ruby
SomeOtherPresenter.new(User.new)
```

### ActionController integration

Now, where do we put our presenters? Ideally, you'd want to expose them in your
controller. Oprah avoids monkey patching and generally it's good to be aware of
what's going on, even if that means to be (at least a little bit) explicit.

Here's how you can use Oprah presenters from your controller:

``` ruby
class UsersController < ApplicationController
  def show
    @user = present User.find(params[:id])
  end
end
```

This will also take care of passing the correct view context to the presenter,
which you can access with the `#view_context` (or shorter, `#h`) instance
method.

## Collections

Oprah has basic support for collections with `.present_many`. It will simply
apply it's `.present` behavior to each object in the given collection:

``` ruby
users = [User.new, User.new]
presenters = Oprah.present_many(users)

presenters.first.kind_of?(UserPresenter)
# => true

presenters.last.kind_of?(UserPresenter)
# => true
```

Of course, this works in controllers, too:

``` ruby
class UserController < ApplicationController
  def index
    @users = present_many User.all
  end
end
```

## Associations

You can also automatically use presenters for your associations using the
`#presents_one` and `#presents_many` macros. Let's say you have the following
`Project` model:

``` ruby
class Project
  has_many :users
  has_one :owner, class_name: "User"
end
```

Oprah lets you easily wrap the associated objects:

``` ruby
class ProjectPresenter < Oprah::Presenter
  presents_many :users
  presents_one :owner
end
```

Note that you don't need to explicitly state the association class.

## Composition

Let's say you extraced some behaviour out of your model into a reusable module (or
`ActiveSupport::Concern`). Oprah lets you write a single, separate presenter for
this module and automatically chains it to your "main presenter" by walking up the
ancestor chain of the given object.

Let's say we want to mix a shared `Describable` module into our `User` class from
above and render the description to HTML:


``` ruby
module Describable
  def description
    "*AWESOME*"
  end
end

class User
  include Describable
end

class DescribablePresenter < Oprah::Presenter
  def description
    Kramdown::Document.new(object.description).to_html
  end
end
```

You can now access the methods of both, `UserPresenter` *and*
`DescribablePresenter`:

``` ruby
presenter = Oprah.present(User.new)

presenter.description
=> "<p><em>AWESOME</em></p>\n"

presenter.name
# => John Doe
```

### Performance

Of course, looking up all the presenters would imply a performance issue. But
don't worry, Oprah caches all matching presenters for a class (and busts it's
cache on code reloads for a smooth development experience).

### Ordering

Oprah walks your object's ancestor chain in reverse. For example, you'd be
able to access the methods exposed by the `DescribablePresenter` from your
`UserPresenter`. You can even use `super`:

``` ruby
class DescribablePresenter < Oprah::Presenter
  def baz
    "foo"
  end
end

class UserPresenter < Oprah::Presenter
  def baz
    super + "bar"
  end
end

Oprah.present(User.new).baz
# => "foobar"
```

### Choosing presenters

When presenting an object you can optionally choose which presenter classes
to use:

``` ruby
Oprah.present(User.new, only: DescribablePresenter)
```

This parameter takes either a single presenter or an `Array` of presenters.
The presenter(s) given need to match the object's class or one of it's
ancestors. Non-matching presenters given will be ignored.

## Testing

Testing presenters is as simple as testing a regular class. Oprah also
provides couple of helpers to make it even easier:

``` ruby
class UserPresenterTest < Minitest::Test
  include Oprah::TestHelpers

  def setup
    @presenter = present User.new
  end

  def test_presented
    assert_presented @presenter
  end

  def test_name
    assert_equal "John Doe", @presenter.name
  end
end
```

## License

Released under the MIT license. See the LICENSE file for details.

## Author

Tobias Svensson, [@endofunky](https://twitter.com/endofunky), [http://github.com/endofunky](http://github.com/endofunky)
