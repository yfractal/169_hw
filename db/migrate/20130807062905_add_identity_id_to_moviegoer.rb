class AddIdentityIdToMoviegoer < ActiveRecord::Migration
  def change
    add_column :moviegoers, :identity_id, :integer
  end
end
