class AddRateToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :rate, :integer
  end
end
