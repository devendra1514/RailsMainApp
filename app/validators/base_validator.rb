module BaseValidator
  extend ActiveSupport::Concern

  private
    def add_error(record, attribute, message)
      record.errors.add(attribute, message)
    end

    def present?(value)
      value.present?
    end
end
