class User < ApplicationRecord
  validates :email, uniqueness: {message: "Email already exists", sub_message: "Please enter a unique email address"}
  validates :email, presence: { message: "Email must be provided"}

  validate :email_domain_not_allowed

  private
  def email_domain_not_allowed
    if email && email.match(/@(gmail|hotmail|yahoo)\./i)
      errors.add(:email, message: "Please add a valid domain.", sub_message: "It cannot be from Gmail, Hotmail, or Yahoo domain")
    end
  end
end
