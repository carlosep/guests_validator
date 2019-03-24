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
        end
      end
    end
  end
end
