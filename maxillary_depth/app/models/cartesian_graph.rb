class CartesianGraph
    attr_accessor :line1, :line2

    def areLinesPerpendicular
        if (self.line1.slope < 0) && (self.line2.slope < 0)
            return True
    end

    def doLinesIntersect
            determinant =  (   (self.line1.point_b.x - self.line1.point_a.x) 
                             * (self.line2.point_b.y - self.line2.pont_a.y) )
                           - 
                           (  (self.line2.point_b.x - self.line2.point_a.x) 
                             * (self.line1.point_b.y - self.line1.point_a.y) );
            
            if (determinant === 0) 
              return false;
            else
              lambda =  (  (  (self.line2.point_b.y - self.line2.pont_a.y) 
                            * (self.line2.point_b.x - self.line1.point_a.x) )
                        + 
                          (   (self.line2.point_a.x - self.line2.point_b.x) 
                            * (self.line2.point_b.y - self.line1.point_a.y) )
                        )                         
                        / determinant;

              gamma =  (  (   (self.line1,point_a.y - self.line1.point_b.y) 
                            * (self.line2.point_b.x - self.line1.point_a.x) )
                        + 
                          ( (self.line1.point_b.x - self.line1.point_a.x) 
                            * (s - self.line1.point_a.y) )
                        ) 
                        / determinant;
              return (0 < lambda && lambda < 1) && (0 < gamma && gamma < 1);
            end
    end

end