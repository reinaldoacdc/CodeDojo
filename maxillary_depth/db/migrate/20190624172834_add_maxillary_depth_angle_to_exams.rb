class AddMaxillaryDepthAngleToExams < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :maxillary_depth_angle, :float
  end
end
