class TimezoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.present?
      record.errors.add(attribute, 'must be present')
      return
    end
    unless ActiveSupport::TimeZone[value]
      record.errors.add(attribute, 'is not valid')
      return
    end
  end
end
