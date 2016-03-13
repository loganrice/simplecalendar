# Simplecalendar

A jQuery plugin that creates a simple month calendar.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simplecalendar', :github => 'loganrice/simplecalendar'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplecalendar

## Usage
Add the following to ./app/assets/javascripts/application.js
  //= require simple_calendar

Add the following to ./app/assets/stylesheets/application.scss
  @import 'simple_calendar'

To Use, create a div html element.
> # example February
  options = { 
              month: 2,
              year: 2016,
              events: [{
                  "2/8/2016": "text"
                 }, {
                   "2/9/2016": "text"
                 }, { 
                   "2/8/2016": "text"
                 }, {
                   "2/29/2016": "text"
                 }]
            }

$("#myNewDivElement").simpleCalendar(options)
