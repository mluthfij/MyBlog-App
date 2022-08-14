class AddReplytoToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :replyto, :string
  end
end
