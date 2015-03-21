# Carendar

Pure CSS rendering for week calendars.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carendar

## Usage

    Carendar::Calendar.new(first_day, last_day, array_of_item_hashes)

Example:

    r = Random.new
    week = DateTime.now.beginning_of_week
    ungrouped_items = 40.times.map do |i|
      day = r.rand(12).to_i
      s_time = r.rand(265).to_i
      e_time = r.rand([268 - s_time - 1, 60].min + 15).to_i + 1 + s_time
      opts = {
        title: Faker::Lorem.words(2).join(" ")
      }
      if s_time.even?
        opts[:class] = 'important'
      end
      {starts_at: week + day.days + (5* s_time).minutes,
       ends_at: week + day.days + (5*e_time).minutes,
       options: opts }
    end
    @calendar = Carendar::Calendar.new(DateTime.now.beginning_of_week, DateTime.now.end_of_week + 1.week, ungrouped_items)


## Contributing

1. Fork it ( https://github.com/[my-github-username]/carendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
