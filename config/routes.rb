# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'application#forbidden_exception', via: :all

  mount Api => '/api'

  match '*path', to: 'application#route_not_found', via: :all
end
