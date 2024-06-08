class EmailValidator < ActiveModel::EachValidator
  include BaseValidator

  def validate_each(record, attribute, value)
    return add_error(record, attribute, "must be present") unless present?(value)

    normalized_email = value.strip.downcase
    record[attribute] = normalized_email

    unless valid_email_format?(normalized_email)
      return add_error(record, attribute, "address is not valid")
    end

    if email_already_taken?(record.class, normalized_email)
      return add_error(record, attribute, "is already taken")
    end
  end

  private

  def valid_email_format?(email)
    email =~ URI::MailTo::EMAIL_REGEXP
  end

  def email_already_taken?(klass, email)
    klass.exists?(email: email)
  end
end
