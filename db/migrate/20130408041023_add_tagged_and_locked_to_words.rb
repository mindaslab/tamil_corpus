class AddTaggedAndLockedToWords < ActiveRecord::Migration
  def change
    add_column :words, :tagged, :boolean, default: false # is true when the word has atleast one tag
    add_column :words, :locked, :boolean, default: false # is true wwhen the admin locks the wword out of editing
  end
end
