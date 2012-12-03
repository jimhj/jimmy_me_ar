class CreateBlogTable < ActiveRecord::Migration
  def up
    create_table :blogs do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.string :tags
      t.timestamps
    end

    add_index(:blogs, :slug)
    add_index(:blogs, :created_at)
  end

  def down
  end
end
