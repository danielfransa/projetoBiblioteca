class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: "Livro cadastrado com sucesso!"
    else
      flash[:alert] = "Erro ao cadastrar livro."
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to books_path, notice: "Livro atualizado com sucesso!"
    else
      flash[:alert] = "Erro ao atualizar livro."
      render :edit
    end
  end

  def new_borrow
    @book = Book.find(params[:id])
  end

  def borrow
    @book = Book.find(params[:id])
    user = User.find(params[:user_id])

    if @book.status == "disponível" && @book.update(status: "emprestado", user_id: user.id)
      redirect_to books_path, notice: "O livro '#{@book.title}' foi emprestado para #{user.name}."
    else
      redirect_to books_path, alert: "Não foi possível emprestar o livro '#{@book.title}'."
    end
  end

  def new_return
    @book = Book.find(params[:id])
    give_back
  end

  def give_back
    @book = Book.find(params[:id])
    if @book.status == "emprestado"
      @book.update(status: "disponível", user_id: nil)

      redirect_to books_path, notice: "O livro '#{@book.title}' foi devolvido com sucesso."
    else
      redirect_to books_path, alert: "Este livro não está emprestado."
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :status)
  end
end
