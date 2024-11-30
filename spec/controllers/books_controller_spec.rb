require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    it 'atribui todos os livros a @books' do
      book
      get :index
      expect(assigns(:books)).to eq([ book ])
    end

    it 'renderiza o template :index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'com parâmetros válidos' do
      it 'cria um novo livro' do
        expect {
          post :create, params: { book: attributes_for(:book) }
        }.to change(Book, :count).by(1)
      end

      it 'redireciona para a página de index com mensagem de sucesso' do
        post :create, params: { book: attributes_for(:book) }
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq("Livro cadastrado com sucesso!")
      end
    end

    context 'com parâmetros inválidos' do
      it 'não cria um novo livro' do
        expect {
          post :create, params: { book: { title: '', author: '' } }
        }.not_to change(Book, :count)
      end

      it 'renderiza o template :new com mensagem de erro' do
        post :create, params: { book: { title: '', author: '' } }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq("Erro ao cadastrar livro.")
      end
    end
  end

  describe 'PATCH #update' do
    context 'com parâmetros válidos' do
      it 'atualiza o livro e redireciona com mensagem de sucesso' do
        patch :update, params: { id: book.id, book: { title: 'Novo Título' } }
        expect(book.reload.title).to eq('Novo Título')
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq("Livro atualizado com sucesso!")
      end
    end

    context 'com parâmetros inválidos' do
      it 'não atualiza o livro e renderiza o template :edit' do
        patch :update, params: { id: book.id, book: { title: '' } }
        expect(book.reload.title).not_to eq('')
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to eq("Erro ao atualizar livro.")
      end
    end
  end
end
