class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.references :patient, foreign_key: true
      t.point :point_n
      t.point :point_a
      t.point :point_po
      t.point :point_or

      t.timestamps
    end
  end
end
