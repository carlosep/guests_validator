class Guest < ApplicationRecord
  belongs_to :event

  def arrived_at(date_time)
    self.time_of_arrival = date_time
    set_status
  end

  def set_status
    self.status = if time_of_arrival <= event.min_tolerance
                    'early'
                  elsif time_of_arrival <= event.max_tolerance
                    'on_time'
                  elsif time_of_arrival > event.ends_at
                    'event_over'
                  else
                    'late'
                  end
  end
end
