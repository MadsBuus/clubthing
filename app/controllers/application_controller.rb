# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  include SimplestAuth::Controller

  before_filter :authorized

  def authorized
    #TODO apply better place for this
    logger.info(controller_name)
    logger.info(action_name)
    redirect_to new_session_path unless logged_in? || controller_name == 'sessions'
  end
end
