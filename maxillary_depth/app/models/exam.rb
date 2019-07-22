class Exam < ApplicationRecord
  belongs_to :patient
  validates :patient_id, presence: true
  after_initialize  :calc_angle, if: :valid?


  attr_accessor :point_n_x, :point_n_y
  attr_accessor :point_a_x, :point_a_y
  attr_accessor :point_po_x, :point_po_y
  attr_accessor :point_or_x, :point_or_y



  def calc_angle
    slope1 = (point_a.y - point_n.y)   / (point_a.x - point_n.x)
    slope2 = (point_or.y - point_po.y) / (point_or.x - point_po.x)

    ang = (Math.atan(slope1) - Math.atan(slope2)).abs
    
    fac = [1, Math::PI / 180];
    rad = 0;
    ppl = 2;


    if (slope1 < 0) && (slope2 < 0)
      abl = ( ((ang * fac[rad]) / fac[1])  )
    else
      abl = (  180 - ((ang * fac[rad]) / fac[1])  )
    end
    
    write_attribute(:maxillary_depth_angle, abl)
  end
  
end
