#Implementation
#       provide a "Placeholder" for an object to control references to it.
#       A client obtains a reference to a Proxy, the client then handles the proxy 
#       in the same way it handles RealSubject and thus invoking the method 
#       doSomething(). At that point the proxy can do different things prior to 
#       invoking RealSubject�s doSomething() method. The client might create 
#       a RealSubject object at that point, perform initialization, check permissions 
#       of the client to invoke the method, and then invoke the method on the object. 
#       The client can also do additional tasks after invoking the doSomething() method, 
#       such as incrementing the number of references to the object.
#
#Collaborators
#       Subject::{}
#           Interface implemented by the RealSubject and representing its services. 
#           The interface must be implemented by the proxy as well so that the proxy 
#           can be used in any location where the RealSubject can be used.
#       Proxy::{}
#           Maintains a reference that allows the Proxy to access the RealSubject.
#           Implements the same interface implemented by the RealSubject so that the 
#           Proxy can be substituted for the RealSubject.
#           Controls access to the RealSubject and may be responsible for its 
#           creation and deletion.
#           Other responsibilities depend on the kind of proxy.
#       RealSubject::{}
#           The real object that the proxy represents.
#
#Applicability & Examples
#       Virtual Proxy 
#       Security Proxies
#
#Related Patterns
#       Adapter Design Pattern - The adapter implements a different interface to the 
#       object it adapts where a proxy implements the same interface as its subject.
#       Decorator Design Pattern - A decorator implementation can be the same as 
#       the proxy however a decorator adds responsibilities to an object while a proxy 
#       controls access to it.
#
require 'etc'
class AccountProtectionProxy
  def initialize(real_account, owner_name)
    @subject = real_account
    @owner_name = owner_name
  end

  def method_missing(name, *args)
    check_access
    @subject.send(name, *args)
  end

  def check_access
    if Etc.getlogin != @owner_name
      raise "Illegal access: #{@owner_name} cannot access account."
    end
  end
end

class BankAccount
  attr_reader :balance

  def initialize(starting_balance=0)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

class BankAccountProxy
  def initialize(real_object)
    @real_object = real_object
  end

  def balance
    @real_object.balance
  end

  def deposit(amount)
    @real_object.deposit(amount)
  end

  def withdraw(amount)
    @real_object.withdraw(amount)
  end
end

class UniversalAccountProxy
  def initialize(real_account)
    @subject = real_account
  end

  def method_missing(name, *args)
    puts("Delegating #{name} message to subject.")
    @subject.send(name, *args)
  end
end

class VirtualAccountProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def deposit(amount)
    s = subject
    return s.deposit(amount)
  end

  def withdraw(amount)
    s = subject
    return s.withdraw(amount)
  end

  def balance
    s = subject
    return s.balance
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end

account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)

proxy = BankAccountProxy.new(account)
proxy.deposit(50)
proxy.withdraw(10)

auth_proxy = AccountProtectionProxy.new(account, 'attila')
auth_proxy.deposit(50)
auth_proxy.withdraw(10)

puts "The balance for account is #{auth_proxy.balance}"

# Try the virtual proxy
account = VirtualAccountProxy.new { BankAccount.new(10) }

generic_proxy = UniversalAccountProxy.new(BankAccount.new(100))
generic_proxy.deposit(25)
generic_proxy.withdraw(50)
puts("Account balance is now: #{generic_proxy.balance}")

# Try the account_protection_proxy with method_missing
s = AccountProtectionProxy.new("a simple string", 'attila')
puts("The length of the string is #{s.length}")

s = AccountProtectionProxy.new("a simple string", 'fred')
puts("The length of the string is #{s.length}")


