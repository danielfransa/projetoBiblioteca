class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :status, default: 'disponível'
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
