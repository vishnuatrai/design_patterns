#Implementation
#       Provide a way to access the elements of an aggregate object sequentially without 
#       exposing its underlying representation.
#       The abstraction provided by the iterator pattern allows you to modify the collection 
#       implementation without making any changes outside of collection
#       access contents of a collection without exposing its internal structure.
#       support multiple simultaneous traversals of a collection.
#       provide a uniform interface for traversing different collection.
#
#Collaborators
#       IIterator::{}
#           This interface represent the AbstractIterator, defining the iterator
#       ProductIterator::{}
#           This is the implementation of Iterator(implements the IIterator interface)
#       IContainer::{}
#           This is an interface defining the Agregate
#       ProductsCollection::{}
#           An implementation of the collection
#
#Specific problems and implementation
#       Iterator and multithreading
#       External vs. internal iterators
#       Who defines the traversal algorithm?
#           
class Account
  attr_accessor :name, :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def <=>(other_account)
    balance <=> other_account.balance
  end
end

class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block)
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end


portfolio = Portfolio.new
portfolio.add_account Account.new('red', 2000)
portfolio.add_account Account.new('blue', 1000)
portfolio.add_account Account.new('green', 500)

puts portfolio.any? { |account| account.balance > 2000 }
puts portfolio.all? { |account| account.balance >= 10 }


