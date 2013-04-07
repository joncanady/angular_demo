class AddAvatars < ActiveRecord::Migration
  def up
    add_column :entries, :avatar_url, :string
  end

  def down
    remove_column :entries, :avatar_url
  end
end
