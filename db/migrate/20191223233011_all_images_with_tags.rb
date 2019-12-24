class AllImagesWithTags < ActiveRecord::Migration[5.2]
  def up
    no_tag_images = execute <<-SQL
      SELECT id
      From images
      WHERE id not in (SELECT Distinct taggable_id
                       From taggings
                       Where taggable_type = 'Image')
    SQL

    tag_id = insert <<-SQL
      INSERT INTO tags (name) VALUES ('needs-tagging')
    SQL

    no_tag_images.each do |img|
      exec_insert "INSERT INTO taggings (tag_id,taggable_type,taggable_id,created_at,context)
                   VALUES ($1,'Image',$2, $3, 'tags')",
                  'SQL', [[nil, tag_id], [nil, img['id']], [nil, Time.zone.now]]
    end
  end

  def down
    execute <<-SQL
        DELETE FROM taggings
        WHERE tag_id IN (SELECT id FROM tags WHERE name = 'needs-tagging' )
    SQL

    execute <<-SQL
      DELETE FROM tags
      WHERE name = 'needs-tagging'
    SQL
  end
end
