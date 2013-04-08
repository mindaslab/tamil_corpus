class CreateTagsWordsTable < ActiveRecord::Migration
  def up
    create_table(:tags_words, id: false) do |t|
      t.integer :tag_id
      t.integer :word_id
    end
    add_index(:tags_words, :tag_id)
    add_index(:tags_words, :word_id)
  end

  def down
    drop_table :tags_words
  end
end
