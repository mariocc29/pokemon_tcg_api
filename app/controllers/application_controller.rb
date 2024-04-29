# frozen_string_literal: true

# ApplicationController: Base controller handling common functionality for the application.
# This includes handling custom exceptions and providing a consistent JSON response format.
class ApplicationController < ActionController::API
  rescue_from ApplicationException::BaseException, with: :handle_application_exception

  # Handles custom exceptions by rendering a JSON response with the exception details.
  def handle_application_exception(exception)
    render json: { error: exception.to_h }, status: exception.status
  end

  # Raises a ForbiddenException to indicate insufficient permissions, triggering the handle_application_exception method.
  def forbidden_exception
    raise ApplicationException::ForbiddenException
  end

  # The `route_not_found` method is responsible for raising a `RoutingException` when a route is not found.
  def route_not_found
    raise ApplicationException::RoutingException.new(request.method, request.path)
  end
end
