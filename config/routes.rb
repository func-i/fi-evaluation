FiEvaluation::Application.routes.draw do
  root to: 'games#show'
  resource :games do
    post :bet
  end
end
