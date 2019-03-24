module GuestsValidator
  class Base < Grape::API
   mount GuestsValidator::V1::Events
   mount GuestsValidator::V1::Guests
  end
end