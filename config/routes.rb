Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/", to: "welcome#index" #首頁標準寫法
  root "welcome#index" #另一種首頁寫法


  resources :candidates #加上這一行，底下的一堆routes就不用自己打了
  # resources :candidates, only: [index:, show:] 只顯示 index 跟 show
  # resources :candidates, except: [index:, show:] index 跟 show 不要，其他都要
  # get "/candidates/new", to: "candidates#new"
  # post "candidates", to: "candidates#create"
end

