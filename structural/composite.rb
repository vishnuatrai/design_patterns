#Implementation
#       The intent of this pattern is to compose objects into tree structures 
#       to represent part-whole hierarchies.
#       Composite lets clients treat individual objects and compositions of 
#       objects uniformly.
#       The composite pattern applies when there is a part-whole hierarchy of objects 
#       and a client needs to deal with objects uniformly regardless of the fact that 
#       an object might be a leaf or a branch. 
#
#Collaborators
#       Component::{}
#           Component is the abstraction for leafs and composites. It defines the 
#           interface that must be implemented by the objects in the composition. 
#           For example a file system resource defines move, copy, rename, and 
#           getSize methods for files and folders.
#       Leaf::{}
#           Leafs are objects that have no children. They implement services described 
#           by the Component interface. For example a file object implements move, copy, 
#           rename, as well as getSize methods which are related to the Component interface.
#       Composite::{}
#           A Composite stores child components in addition to implementing methods defined 
#           by the component interface. Composites implement methods defined in the 
#           Component interface by delegating to child components. In addition composites 
#           provide additional methods for adding, removing, as well as getting components.
#       Client::{}
#           The client manipulates objects in the hierarchy using the component interface.
#
#Applicability & Examples
#       Graphics Drawing Editor
#       File System Implementation
#
#Related Patterns
#       Decorator Pattern - Decorator is often used with Composite. When decorators 
#       and composites are used together, they will usually have a common parent class. 
#       So decorators will have to support the Component interface with operations like 
#       Add, Remove, and GetChild.
#
class Task
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0 
  end

  def total_number_basic_tasks
    1
  end
end

class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0
  end
end

class AddLiquidTask < Task
  def initialize
    super('Add Liquid Task')
  end

  def get_required_time
    2.0
  end
end

class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end

  def get_time_required
    3.0
  end
end

class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def <<(task)
    @sub_tasks << task
    task.parent = self
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def [](index)
    @sub_tasks[index]
  end

  def get_time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.get_time_required }
    time
  end

  def total_number_basic_tasks
    total = 0
    @sub_tasks.each { |task| total += task.total_number_basic_tasks }
    total
  end
end

class MakeBatterTask < CompositeTask
  def initialize
    super('Make Batter')
    @sub_tasks = []
    self.<<(AddDryIngredientsTask.new)
    self.<<(AddLiquidTask.new)
    self.<<(MixTask.new)
  end
end

main_task = MakeBatterTask.new
puts "The main task will take #{main_task.get_time_required} minutes"

