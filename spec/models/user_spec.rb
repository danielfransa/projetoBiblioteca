require 'rails_helper'

RSpec.describe User, type: :model do
  # Testando validações
  describe 'validations' do
    it { should validate_presence_of(:name).with_message("O Nome é obrigatório!") }

    it 'valida a presença do email' do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'valida o formato do email' do
      user = User.new(email: 'email_invalido')
      user.valid?
      expect(user.errors[:email]).to include("não é um email válido")
    end

    it 'permite email com formato válido' do
      user = User.new(email: 'email@valido.com')
      user.valid?
      expect(user.errors[:email]).to be_empty
    end
  end
end
