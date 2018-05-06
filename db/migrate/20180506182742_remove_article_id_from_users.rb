class RemoveArticleIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :article_id, :integer
  end
end
