module JsonWebTokenValidation
  extend ActiveSupport::Concern

  included do
    before_action :validate_token!
  end

  def validate_token!
    token = request.headers[:token] || params[:token]
    decode_hash = JsonWebToken.decode(token)
    @id = decode_hash[:id]
    @current_user = User.find(@id)
    set_timezone
  rescue ActiveRecord::RecordNotFound
    return render json: { error: "User not found" }, status: :not_found
  rescue JWT::ExpiredSignature
    return render json: { errors: ["Token is expired"] }, status: :unauthorized
  rescue JWT::DecodeError => e
    return render json: { errors: ["Token decode error"] }, status: :unauthorized
  end

  def set_timezone(timezone='UTC')
    Time.zone = @current_user&.timezone || timezone
  end

  def current_user
    @current_usee
  end
end
