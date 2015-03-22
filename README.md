# Carendar

Pure CSS rendering for week calendars.

Limitations

  * For positioning days have to rastered. The example shows a 5 minute grid. The times of the events have to be rounded to the grid. The grid resolution can be passed as parameter to the sass mixin
  * No events across day borders

## Demo

Visit the [demo rails app](https://carendar-demo.herokuapp.com/) and the [source for the demo](https://github.com/axelerator/carendar-demo)

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


First you have to create a `Calendar` object containing all calendar items.

    Carendar::Calendar.new(first_day, last_day, array_of_item_hashes)

This can be constructed from a simple array of hashes, where each item is represented by hash with the keys
`starts_at, ends_at, options`.

Styling is provided via sass mixin. You have to at least include the `carendar` mixin to get
the layout.

The mixin takes three parameters
  
  * Height of a day for the week view
  * Height of a day got the month vew
  * resolution of the minutes grid for the week view (for positioning events relative to the top)

Custom styling is easily done by selecting the child classes of your calendar class.

    @import 'carendar'

    .my-calendar
      +carendar(500px, 50px, 5)
      .day
        border-left: 1px solid #EEE
        border-top: 1px solid #EEE

        > div
          background-color: #EEE
          text-align: center
          font-size: 10pt
          color: #999

      .item
        border: 1px solid #DDD
        background-color: #EEE
        font-size: 8pt
        z-index: 5
        &:hover
          z-index: 10


        &.important
          background-color: #FEE


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

Rendering in the template is called with the `carendar`-helper, with the previously constructed calendar object.

    <%= carender(@calender) %>

## Screenshot

![screenshot of sample calendar rendering](https://raw.githubusercontent.com/axelerator/carendar/master/screenshot.jpg)


## Contributing

1. Fork it ( https://github.com/[my-github-username]/carendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
