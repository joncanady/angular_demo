Angular::Application.routes.draw do
  resources :entries
  root to: "pages#landing"
end
