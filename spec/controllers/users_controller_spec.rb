require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    it 'atribui todos os usuários a @users' do
      user # Garante que o usuário foi criado
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it 'renderiza o template :index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'atribui um novo usuário a @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renderiza o template :new' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'com parâmetros válidos' do
      it 'cria um novo usuário' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redireciona para a página de index com mensagem de sucesso' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq("Usuário cadastrado com sucesso!")
      end
    end

    context 'com parâmetros inválidos' do
      it 'não cria um novo usuário' do
        expect {
          post :create, params: { user: { name: '', email: '' } }
        }.not_to change(User, :count)
      end

      it 'renderiza o template :new com mensagem de erro' do
        post :create, params: { user: { name: '', email: '' } }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq("Erro ao cadastrar usuário.")
      end
    end
  end

  describe 'GET #edit' do
    it 'atribui o usuário correto a @user' do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renderiza o template :edit' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'com parâmetros válidos' do
      it 'atualiza o usuário e redireciona com mensagem de sucesso' do
        patch :update, params: { id: user.id, user: { name: 'Nome Atualizado' } }
        expect(user.reload.name).to eq('Nome Atualizado')
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq("Usuário atualizado com sucesso!")
      end
    end

    context 'com parâmetros inválidos' do
      it 'não atualiza o usuário e renderiza o template :edit' do
        patch :update, params: { id: user.id, user: { name: '' } }
        expect(user.reload.name).not_to eq('')
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to eq("Erro ao atualizar usuário.")
      end
    end
  end
end
