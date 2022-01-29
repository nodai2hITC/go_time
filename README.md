# GoTime - formats Time like Golang

Do you remember the format of strftime? Wouldn't you like to use a concrete and understandable format for example "01/02 03:04:05PM '06 -0700" like in the Golang?

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'go_time'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install go_time

## Usage

```ruby
require "go_time"
time = Time.utc(2012, 3, 4, 5, 6, 7)
GoTime.format(time, "01/02 03:04:05PM '06 -0700")
#                => "03/04 05:06:07AM '12 +0000"
```

or 

```ruby
require "go_time"
using GoTime
time = Time.utc(2012, 3, 4, 5, 6, 7, 80000)
time.format("2006/01/02 15:04:05.000")
#        => "2012/03/04 05:06:07.080"
```

or 

```ruby
require "go_time/strftime"
time = Time.utc(2012, 3, 4, 5, 6, 7, 80000)
time.strftime("Mon Jan _2 15:04:05 2006")
#          => "Sun Mar  4 17:06:07 2012"
```

For more information about format, please refer to the [Golang source code](https://golang.org/src/time/format.go).

## Extensions

GoTime has extensions that support date and time representations in various languages.

```ruby
require "go_time/ext/ja" # Japanese
time = Time.utc(2019, 5, 6, 7, 8, 9)
time.strftime("平成十八年（二〇〇六年）一月二日(火) 午後三時四分五秒")
#            => "令和元年（二〇一九年）五月六日(月) 午前七時八分九秒"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/go_time. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/go_time/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GoTime project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/go_time/blob/main/CODE_OF_CONDUCT.md).
