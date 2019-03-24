module GuestsValidator
  module V1
    class Guests < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      resource :guests do
        desc 'Return a specific guest'
        route_param :id do
          get do
            guest = Guest.find(params[:id])
            present guest
          end

          post do
            date_time = Time.current
            guest = Guest.find(params[:id])
            event = guest.event
            guest.time_of_arrival = date_time
            guest.status = if guest.time_of_arrival <= event.min_tolerance
                             'early'
                           elsif guest.time_of_arrival <= event.max_tolerance
                             'on_time'
                           else
                             'late'
                           end
            if guest.save!
              present guest
            else
              'An unexpected error ocurred.'
            end
          end
        end
      end
    end
  end
end
