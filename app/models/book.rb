class Book < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: { message: "O título é obrigatório!" }
  validates :author, presence: { message: "O autor é obrigatório!" }

  def available?
    status == "disponível"
  end
end
