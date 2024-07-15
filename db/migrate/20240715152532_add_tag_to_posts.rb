class AddTagToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :tag, :integer, default: 0, null: false
  end
end
