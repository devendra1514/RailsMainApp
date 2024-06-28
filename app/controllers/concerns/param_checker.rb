module ParamChecker
  extend ActiveSupport::Concern

  included do
    before_action :check_required_params
  end

  class_methods do
    def require_params_for(action, *params)
      @action_required_params ||= {}
      @action_required_params[action] = params
    end

    def required_params_for(action)
      @action_required_params ||= {}
      @action_required_params[action] || []
    end
  end

  private

  def check_required_params
    @error_messages = []
    action = action_name.to_sym
    required_params = self.class.required_params_for(action)

    required_params.each do |param|
      param_missing?(params, param, "")
    end

    if @error_messages.any?
      render json: { errors: @error_messages }, status: :bad_request
    end
  end

  def param_missing?(params, key, chain)
    if key.is_a?(Hash)
      key.each do |nested_key, nested_value|
        if params[nested_key].nil?
          @error_messages << "#{nested_key} must be present#{message(chain)}"
        else
          param_missing?(params[nested_key], nested_value, "#{chain}#{'.' unless chain.empty?}#{nested_key}")
        end
      end
    elsif key.is_a?(Array)
      key.each do |param|
        param_missing?(params, param, chain)
      end
    else
      if params[key].nil?
        @error_messages << "#{key} must be present#{message(chain)}"
      end
    end
  end

  def message(chain)
    chain.present? ? " inside #{chain}" : ''
  end
end
