Rails.application.routes.draw do

  mount Gitlab::Engine => "/"
end
