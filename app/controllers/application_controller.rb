class ApplicationController < ActionController::Base
  include Pagy::Backend
  include RenderResponse
  protect_from_forgery with: :null_session
end
