MailingList::Application.routes.draw do
  root "application#index"
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :contacts
    end
  end
end
