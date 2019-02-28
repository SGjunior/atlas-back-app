class Api::V1::BaseController < ActionController::API
  # include Pundit
  include ActionController::MimeResponds

  # after_action :verify_authorized, except: :index         # TODO(SGjunior) :  Disabling pundit check
  # after_action :verify_policy_scoped, only: :index        # TODO(SGjunior) :  Disabling pundit check

  rescue_from StandardError,                with: :internal_server_error
  # rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  # rescue_from Pundit::AuthorizationNotPerformedError, with: :authorization_not_performed
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  private
  def execute_statement(sql)
    results = ActiveRecord::Base.connection.execute(sql)

    if results.present?
      return results
    else
      return nil
    end
  end

  def authorization_not_performed(exception)
    begin
      Info.create(comment: "AUTHORIZATION_NOT_PERFORMED", status: "401", infoable: current_user.current_session, session: current_user.current_session, body: exception.to_json)
    rescue
    end

    render json: {
      error: "authorization_not_performed for #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized

  end

  def user_not_authorized(exception)
    begin
      Info.create(comment: "USER_NOT_AUTHORIZED", status: "401", infoable: current_user.current_session, session: current_user.current_session, body: exception.to_json)
    rescue
    end

    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def internal_server_error(exception)

    if Rails.env.development?
      response = { type: exception.class.to_s, message: exception.message, backtrace: exception.backtrace }
    else
      # Adding more information to the production env
      response = { type: exception.class.to_s, message: exception.message, backtrace: exception.backtrace }
      # response = { error: "Internal Server Error" }
    end
    render json: response, status: :internal_server_error
  end
end
