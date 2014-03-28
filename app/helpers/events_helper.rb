module EventsHelper

  def date(datetime)
    datetime.strftime '%B %e %Y'
  end

  def time(datetime)
    datetime.strftime('%l:%M %p').strip
  end

  def month_calendar(events)
    content_tag 'section', class: 'month_calendar' do
      # calls method from simple_calendar gem with particular options
      options = {
        time_selector: 'start',
        class: nil,
        prev_text: '« previous',
        next_text: 'next »'
      }
      if can? :create, Event
        add_link = lambda{ |date| link_to '+', new_event_path(start_day: date), class: 'add', title: 'add event on this day' }
        options[:empty_date] = add_link
        options[:not_empty_date] = add_link
      end
      calendar events, options do |event|
        yield(event)
      end
    end
  end

end

# overriding header method for calendar so that we can insert the number of events during that month
# for now relies on using instance variable @events
# original: https://github.com/excid3/simple_calendar/blob/master/lib/simple_calendar/view_helpers.rb
module SimpleCalendar
  module ViewHelpers
    def month_header(selected_month, options)
      content_tag :h2 do
        previous_month = selected_month.advance :months => -1
        next_month = selected_month.advance :months => 1
        tags = []
        tags << month_link(options[:prev_text], previous_month, options[:params], {:class => "previous-month"})
        tags << "#{I18n.t("date.month_names")[selected_month.month]} #{selected_month.year} &ndash; #{pluralize @events.length, 'Event'}"
        tags << month_link(options[:next_text], next_month, options[:params], {:class => "next-month"})
        tags.join.html_safe
      end
    end
  end
end