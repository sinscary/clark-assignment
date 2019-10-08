Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/process_rewards', to: 'rewards#process_rewards'
end
