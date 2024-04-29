# frozen_string_literal: true

# Module containing exception handlers for the application.
module ExceptionHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ApplicationException::BaseException do |e|
      error!({ error: e.to_h }, e.status)
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      bad_request_error = ApplicationException::BadRequestException.new e.message
      error!({ error: bad_request_error.to_h }, bad_request_error.status)
    end

    if ENV['RACK_ENV'] == 'production'
      rescue_from :all do
        internal_server_error = ApplicationException::InternalServerErrorException.new
        error!({ error: internal_server_error.to_h }, internal_server_error.status)
      end
    end
  end
end
