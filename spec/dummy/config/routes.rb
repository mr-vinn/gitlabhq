Rails.application.routes.draw do

  mount Gitlab::Engine => "/gitlab"
end
