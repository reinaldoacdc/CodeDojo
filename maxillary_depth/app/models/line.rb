class Line
    attr_accessor :point_a, :point_b, :slope

    def slope
      return  (self.point_b.y - self.point_a.y)   / (self.point_b.x - self.point_a.x)
    end

    def angle_between_points
      return (Math.atan(self.slope) * 1 / (Math::PI / 180)).round
    end


    def are_points_equals
        if (self.point_a.x == self.point_b.x) && (self.point_a.y == self.point_b.y)
            return True
    end

end
