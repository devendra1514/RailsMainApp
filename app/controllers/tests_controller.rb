class TestsController < ApplicationController
  include ParamChecker

  require_params_for(:create,
    :username,
    :password,
    { meta: [
      { full_name:
        [:first_name,
          :last_name
        ]
      },
      :device_id,
      { device_info: [:device_name] }
    ]},
    :timezone
  )

  def create
    # render_created_response(TestSerializer.new(AdminUser.first), message: "Created")

    # @pagy, @admin_users = pagy(AdminUser.where("email ILIKE ?", "%#{params[:email_search]}%"))
    # render_created_response(TestSerializer.new(@admin_users), message: "Success", pagination: @pagy)

    render_unprocessable_response(["hello", "world"])
  end
end
