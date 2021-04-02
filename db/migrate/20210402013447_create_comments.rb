class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      #「references」はBoardモデルと紐付けるための「borad_id」カラムが作成される。
      #「foreign_key: true」によって、Boardモデルになりidは受け付けなくなる。
      t.references :board, foreign_key: true
      #「null: false」にすることによって、空では受け付けなくなる。
      t.string :name, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
