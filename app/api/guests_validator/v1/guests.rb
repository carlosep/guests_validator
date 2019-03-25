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
            guest = Guest.find(params[:id])
            guest.arrived_at(Time.current)
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
