class AddLinkToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :link, :text
  end
end
