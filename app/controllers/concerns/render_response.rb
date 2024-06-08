module RenderResponse
  extend ActiveSupport::Concern

  def render_created_response(serialize_data, *advance_params)
    advance_params.each do |item|
      serialize_data = serialize_data.to_hash.merge!(item)
    end
    render status: :created, json: serialize_data
  end

  def render_resource_response(serialize_data, *advance_params)
    advance_params.each do |item|
      serialize_data = serialize_data.to_hash.merge!(item)
    end
    render status: :ok, json: serialize_data
  end

  def render_unprocessable_response(errors, *advance_params)
    serialize_data = {}
    serialize_data = serialize_data.merge(errors: errors)
    advance_params.each do |item|
      serialize_data = serialize_data.to_hash.merge!(item)
    end
    render status: :unprocessable_entity, json: serialize_data
  end
end
