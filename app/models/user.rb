class User < ApplicationRecord
  validates :name, presence: { message: "O Nome é obrigatório!" }
  validates :email, presence: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "não é um email válido"
  }
end
