class Book < ApplicationRecord
  belongs_to :user, optional: true

  def available?
    status == "disponível"
  end
end
