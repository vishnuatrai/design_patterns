#Implementation
#       Defines a one-to-many dependency between objects so that when one object changes state, 
#       all its dependents are notified and updated automatically.
#       the change of a state in one object must be reflected in another object without keeping 
#       the objects tight coupled.
#       the framework we are writing needs to be enhanced in future with new observers with 
#       minimal changes.
#
#Collaborators
#       Observable::{}
#           interface or abstract class defining the operations for attaching and de-attaching 
#           observers to the client. In the GOF book this class/interface is known as Subject
#       ConcreteObservable::{}
#           concrete Observable class. It maintain the state of the object and when a change in 
#           the state occurs it notifies the attached Observers.
#       Observer::{}
#           interface or abstract class defining the operations to be used to notify this object
#       ConcreteObserver::{}
#           concrete Observer implementations
#
#Applicability & Examples
#       Model View Controller Pattern
#       Event management
#       News Agency
#
#Related Patterns
#       Factory pattern
#           It's very likely to use the factory pattern to create the Observers so no changes will be 
#           required even in the main framework. The new observers can be added directly in the 
#           configuration files
#       Template Method
#           The observer pattern can be used in conjunction with the Template Method Pattern to make 
#           sure that Subject state is self-consistent before notification
#       Mediator Pattern
#           The mediator pattern can be used when we have cases of complex cases of many subjects an 
#           many observers
#
module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

class Employee
  include Subject
  
  attr_reader :name
  attr_accessor :title, :salary

  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    if salary == new_salary
      return
    end
    @salary = new_salary
    notify_observers
  end
end

class Payroll
  def update(changed_employee)
    puts("Cut a new check for #{changed_employee.name}!")
    puts("His salary is now #{changed_employee.salary}!")
  end
end

class TaxMan
  def update(changed_employee)
    puts("Send #{changed_employee.name} a new tax bill!")
  end
end

fred = Employee.new('Fred', 'Crane Operator', 30000)
fred.add_observer do |changed_employee|
  puts("Cut a new check for #{changed_employee}!")
  puts("His salary is now #{changed_employee.salary}!")
end

fred.salary = 35000
