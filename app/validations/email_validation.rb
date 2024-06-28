class EmailValidation
  include ActiveModel::Validations

  attr_reader :email

  def initialize(email)
    @email = email
  end

  validates
end
