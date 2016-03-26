class SimpleCalendarMonth
  constructor:  (@year, @month) ->

  days: ->
    startDate = new Date(@year, @month, 1).getDate()
    endDate = new Date(@year, @month + 1, 0).getDate()
    [startDate..endDate]
  render: ->


class SimpleCalendarEvent
  constructor: (@year, @month) ->
    @data = _build(@year, @month)
    @startDate = new Date(@year, @month, 1)
    @endDate = new Date(@year, @month + 1, 0)

  _build = (year, month) ->
    calendar = {}
    days = (new SimpleCalendarMonth(year, month)).days()
    for day in days
      calendar[day] = []
    calendar


  add: (details...) =>
    # method takes either 2 params or an array of params
    if Array.isArray(details[0])
      @addEvents(details[0])
    else
      date = details[0]
      event = details[1]
      @addEvent(date, event)

  all: ->
    @data

  weeks: ->
    allWeeks = {}
    weekNumber = 1
    for day, events of @data
      day_of_week = new Date(@year, @month, day).getDay()
      if day_of_week == 1
        weekNumber += 1 unless day == 1
      allWeeks[weekNumber] ?= {}
      allWeeks[weekNumber][day] = events

    allWeeks

  addEvent: (date, details) ->
    date = new Date(date)
    if @startDate <= date <= @endDate
      @data[date.getDate()].push(details)

  addEvents: (events) ->
    for event in events
      date = Object.keys(event)[0]
      @addEvent(date, event)

SimpleCalendarView = 
  fetchMonth: (month) ->
    months = [
      "January", "February", "March"
      "April", "May", "June"
      "July", "August", "September"
      "October", "November", "December"
    ]
    months[month]

  header: (month) ->
    "<h1>
      <button id='calendar-prev-month' class='btn btn-default btn-small pull-left'>
        <span class='glyphicon glyphicon-menu-left'></span>
      </button>
      #{@fetchMonth(month)}
      <button id='calendar-next-month' class='btn btn-default btn-small pull-right'>
        <span class='glyphicon glyphicon-menu-right'></span>
      </button>
    </h1>
    <div class='days-of-the-week'>
      <div>Mon</div>
      <div>Tue</div>
      <div>Wed</div>
      <div>Thur</div>
      <div>Fri</div>
      <div>Sat</div>
      <div>Sun</div>
    </div>"

  day: (date, events=[]) ->
    text = ""
    console.log events
    for key, daysEvents of events
      for k, event of daysEvents
        text += "#{event} "
    "<div class='day'>
      <div class='day__number'>#{date}</div>
      <div class='events'>
        <div>#{text}</div>
      </div>
    </div>"

  lastDayOfMonth: (day, year, month, events) ->
    weekhtml = ""
    dayOfWeek = (new Date(year, month, day)).getDay()
    console.log "day of week is #{dayOfWeek}"
    switch dayOfWeek
      when 0
        weekhtml += @day( new Date(year, month, day).getDate(), events)
      when 1
        weekhtml += @day( new Date(year, month, day).getDate(), events)
        weekhtml += @day( new Date(year, month + 1, 1).getDate())
        weekhtml += @day( new Date(year, month + 1, 2).getDate())
        weekhtml += @day( new Date(year, month + 1, 3).getDate())
        weekhtml += @day( new Date(year, month + 1, 4).getDate())
        weekhtml += @day( new Date(year, month + 1, 5).getDate())
        weekhtml += @day( new Date(year, month + 1, 6).getDate())
      when 2
        weekhtml += @day( new Date(year, month, day).getDate(), events)
        weekhtml += @day( new Date(year, month + 1, 1).getDate())
        weekhtml += @day( new Date(year, month + 1, 2).getDate())
        weekhtml += @day( new Date(year, month + 1, 3).getDate())
        weekhtml += @day( new Date(year, month + 1, 4).getDate())
        weekhtml += @day( new Date(year, month + 1, 5).getDate())
      when 3
        weekhtml += @day( new Date(year, month, day).getDate(), events)
        weekhtml += @day( new Date(year, month + 1, 1).getDate())
        weekhtml += @day( new Date(year, month + 1, 2).getDate())
        weekhtml += @day( new Date(year, month + 1, 3).getDate())
        weekhtml += @day( new Date(year, month + 1, 4).getDate())
      when 4
        weekhtml += @day( new Date(year, month, day).getDate(), events)
        weekhtml += @day( new Date(year, month + 1, 1).getDate())
        weekhtml += @day( new Date(year, month + 1, 2).getDate())
        weekhtml += @day( new Date(year, month + 1, 3).getDate())
      when 5
        weekhtml += @day( new Date(year, month, day).getDate(), events)
        weekhtml += @day( new Date(year, month + 1, 1).getDate())
        weekhtml += @day( new Date(year, month + 1, 2).getDate())
      when 6
        weekhtml += @day( new Date(year, month, day).getDate(), events)
        weekhtml += @day( new Date(year, month + 1, 1).getDate())

    weekhtml


  firstDayOfMonth: (day, year, month, events) ->
    weekhtml = ""
    dayOfWeek = (new Date(year, month, day)).getDay()
    switch dayOfWeek
      when 1
        weekhtml += @day( new Date(year, month, 1).getDate(), events)
      when 2
        weekhtml += @day( new Date(year, month, 0).getDate() )
        weekhtml += @day( new Date(year, month, 1).getDate(), events)
      when 3
        weekhtml += @day( new Date(year, month, -2).getDate() )
        weekhtml += @day( new Date(year, month, -1).getDate() )
        weekhtml += @day( new Date(year, month, 1).getDate(), events)
      when 4
        weekhtml += @day( new Date(year, month, -2).getDate() )
        weekhtml += @day( new Date(year, month, -1).getDate() )
        weekhtml += @day( new Date(year, month, 0).getDate() )
        weekhtml += @day( new Date(year, month, 1).getDate(), events )
      when 5
        weekhtml += @day( (new Date(year, month, -3)).getDate() )
        weekhtml += @day( new Date(year, month, -2).getDate() )
        weekhtml += @day( new Date(year, month, -1).getDate() )
        weekhtml += @day( new Date(year, month, 0).getDate() )
        weekhtml += @day( new Date(year, month, 1).getDate(), events)
      when 6
        weekhtml += @day( new Date(year, month, -4).getDate() )
        weekhtml += @day( new Date(year, month, -3).getDate() )
        weekhtml += @day( new Date(year, month, -2).getDate() )
        weekhtml += @day( new Date(year, month, -1).getDate() )
        weekhtml += @day( new Date(year, month, 0).getDate() )
        weekhtml += @day( new Date(year, month, 1).getDate(), events)
      when 7
        weekhtml += @day( new Date(year, month, -5).getDate() )
        weekhtml += @day( new Date(year, month, -4).getDate() )
        weekhtml += @day( new Date(year, month, -3).getDate() )
        weekhtml += @day( new Date(year, month, -2).getDate() )
        weekhtml += @day( new Date(year, month, -1).getDate() )
        weekhtml += @day( new Date(year, month, 0).getDate() )
        weekhtml += @day( new Date(year, month, 1).getDate(), events )
    weekhtml

  displayText: (day) ->


  week: (week, year, month) ->
    html = "<div class='week'>"
    last_day = new Date(year, month + 1, 0).getDate()

    for day of week
      events = week[day]
      if day == "1"
        html += @firstDayOfMonth(day, year, month, events)
      else if day == last_day.toString()
        html += @lastDayOfMonth(day, year, month, events)
      else
        html += @day(day, events)

    html += "</div>"

class SimpleCalendar
  constructor: (@year, @month) ->
    # subtract 1, date objects months start at 0#
    @month = @month - 1

    @events = new SimpleCalendarEvent(@year, @month)

  render: ->
    html = "<div class='month'>"
    html += @renderHeader()
    day_counter = 1
    for week, events of @events.weeks()
      html += @renderWeek(events, @year, @month)

    html += "</div>"

  eventList: ->
    @events.all()

  renderDay: (date)->
    SimpleCalendarView.day(date)

  renderWeek: (days, year, month) ->
    SimpleCalendarView.week(days, year, month)

  renderHeader: ->
    SimpleCalendarView.header(@month)

  add: (events) ->
    @events.add(events)

window.SimpleCalendar = SimpleCalendar
window.SimpleCalendarMonth = SimpleCalendarMonth
window.SimpleCalendarEvent = SimpleCalendarEvent


$.fn.extend
  simpleCalendar: (options) ->
    # example February
    # options = { 
      # month: 2,
      # year: 2016
      # events: [{
      #           "2/8/2016": "8"
      #          }, {
      #            "2/9/2016": "2"
      #          }, { 
      #            "2/8/2016": "3"
               # }, {
                 # "2/29/2016": "1"
               # }]
    # }
    options.year = new Date().getFullYear() unless options.year?
    options.month = (new Date().getMonth()) + 1 unless options.month?
    calendar = new SimpleCalendar(options.year, options.month)
    calendar.add(options.events)
    
    $.extend options

    return @each () ->
      $(@).html(calendar.render())


