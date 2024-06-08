class TimezoneValidator < ActiveModel::EachValidator
  include BaseValidator

  def validate_each(record, attribute, value)
    return add_error(record, attribute, 'must be present') unless present?(value)
    return add_error(record, attribute, 'is not valid') unless ActiveSupport::TimeZone[value]
  end
end
