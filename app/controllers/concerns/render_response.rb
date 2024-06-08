module RenderResponse
  extend ActiveSupport::Concern

  def render_created_response(serialize_data, *advance_params)
    serialize_data = add_advance_params(serialize_data, advance_params)
    render_response(:created, serialize_data)
  end

  def render_ok_response(serialize_data, *advance_params)
    serialize_data = add_advance_params(serialize_data, advance_params)
    render_response(:ok, serialize_data)
  end

  def render_unprocessable_response(errors, *advance_params)
    serialize_data = {}
    serialize_data = serialize_data.merge(errors: errors)
    serialize_data = add_advance_params(serialize_data, advance_params)
    render_response(:unprocessable_entity, serialize_data)
  end


  private
    def add_advance_params(serialize_data, advance_params)
      advance_params.each do |item|
        serialize_data = serialize_data.to_hash.merge!(item)
      end
      serialize_data
    end

    def render_response(status, data)
      render status: status, json: data
    end
end
