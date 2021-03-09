class AddColumnToBooksTable < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :summary, :string
  end
end
