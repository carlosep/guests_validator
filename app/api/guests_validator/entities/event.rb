module GuestsValidator
  module Entities
    class Event < Grape::Entity
      expose :id
      expose :name
      expose :starts_at
      expose :ends_at
    end
  end
 end
