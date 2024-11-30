require 'rails_helper'

RSpec.describe Book, type: :model do
  # Testando associações
  describe 'associations' do
    it { should belong_to(:user).optional }
  end

  # Testando validações
  describe 'validations' do
    it { should validate_presence_of(:title).with_message("O título é obrigatório!") }
    it { should validate_presence_of(:author).with_message("O autor é obrigatório!") }
  end

  # Testando o método de instância #available?
  describe '#available?' do
    let(:book) { Book.new(status: status) }

    context "quando o status é 'disponível'" do
      let(:status) { 'disponível' }

      it 'retorna true' do
        expect(book.available?).to be true
      end
    end

    context "quando o status não é 'disponível'" do
      let(:status) { 'indisponível' }

      it 'retorna false' do
        expect(book.available?).to be false
      end
    end
 end
end
