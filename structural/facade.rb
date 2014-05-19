#Implementation
#       Provide a unified interface to a set of interfaces in a subsystem. 
#       Facade defines a higher-level interface that makes the subsystem easier to use.
#       Wrap a complicated subsystem with a simpler interface.
#Problem 
#       A segment of the client community needs a simplified interface to the overall 
#       functionality of a complex subsystem.
#
#Solution
#       Identify a simpler, unified interface for the subsystem or component.
#       Design a 'wrapper' class that encapsulates the subsystem.
#       The facade/wrapper captures the complexity and collaborations of the 
#       component, and delegates to the appropriate methods.
#       The client uses (is coupled to) the Facade only.
#       Consider whether additional Facades would add value.
#
#Subsystem 1
class PointCarte
  def initialize(x,y)
    @x = x
    @y = y
  end

  def move(x,y)
    @x += x
    @y += y
  end

  def to_s
    "(#{@x},#{@y})"
  end

  def getX
    @x
  end

  def getY
    @y
  end
end

#Subsystem 1
class PointPolar
  def initialize(r, a)
    @radius = r
    @angle  = a
  end

  def rotate(ang)
    @angle += @ang % 360;
  end

  def to_s
    "[#{@radius}@#{@angle}]"
  end
end

#1. Desired interface: move(), rotate()
class Point
  attr_accessor :pc

  def initialize(x, y)
    @pc = PointCarte.new(x, y) #2. Design a "wrapper" class
  end

  def to_s
    @pc.to_s
  end
  
  #3. Wrapper maps
  def move(x, y)
    @pc.move(x, y)
  end

  def rotate(angle, point_obj)
    x = @pc.getX() - point_obj.pc.getX()
    y = @pc.getY() - o.pc.getY()
    pp = PointPolar.new( Math.sqrt(x*x+y*y), Math.atan2(y,x)*180/Math.PI )
    
    #4. Wrapper maps
    pp.rotate( angle )
    puts "PointPolar is #{pp}"
    r,a = pp.to_s.split("@")
    r = r.to_f
    a = a.to_f

    @pc = PointCarte.new(r*Math.cos(a*Math.PI/180) + point_obj.pc.getX(),
                         r*Math.sin(a*Math.PI/180) + point_obj.pc.getY() )
  end
end

class Line
  def initialize(ori_line, end_line)
    @o = ori_line
    @e = end_line
  end

  def move(x, y)
    @o.move(x, y)
    @e.move(x, y)
  end

  def rotate(angle)
    @e.rotate(angle, @o)
  end

  def to_s
    "origin is #{@o}, end is #{@e}"
  end
end

class FacadeDemo
  def run
    line1 = Line.new( Point.new(2,4), Point.new(5,7) )
    line1.move(-2,-4)
    puts "after move:  #{line1}"

    line1.rotate(45)
    puts "after rotate: #{line1}"

    line2 = Line.new( Point.new(2,1), Point.new(2.866,1.5) )
    line2.rotate(30);
    puts "30 degrees to 60 degrees: #{line2}"
  end
end

facade_demo = FacadeDemo.new
facade_demo.run

