Rails.application.routes.draw do
  mount GuestsValidator::Base, at: "/"
end