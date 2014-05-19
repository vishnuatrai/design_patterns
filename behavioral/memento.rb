#Implementation
#       The intent of this pattern is to capture the internal state of an object without violating 
#       encapsulation and thus providing a mean for restoring the object into initial state when needed.
#       The memento pattern is used when a snapshot of an object's state must be captured so that 
#       it can be restored to that state later and in situations where explicitly passing the state of 
#       the object would violate encapsulation.
#
#Collaborators
#       Memento::{}
#           Stores internal state of the Originator object. The state can include any number 
#           of state variables
#           The Memento must have two interfaces, an interface to the caretaker. This interface must 
#           not allow any operations or any access to internal state stored by the memento and thus 
#           honors encapsulation. The other interface is to the originator and allows the originator 
#           to access any state variables necessary to for the originator to restore previous state
#       Originator::{}
#           Creates a memento object capturing the originators internal state.
#           Use the memento object to restore its previous state.
#       Caretaker::{}
#           Responsible for keeping the memento.
#           The memento is opaque to the caretaker, and the caretaker must not operate on it
#
#Applicability & Examples
#       Simple Calculator with Undo Operation
#
class Memento
  attr_reader :money, :fruits

  def initialize(money)
    @money = money
    @fruits = []
  end

  def add_fruit(fruit)
    @fruits << fruit
  end
end

class Gamer
  attr_reader :money
  @@fruits_name = ["Apple", "Mango", "Grapes", "Orange"]

  def initialize(money)
    @money = money
    @fruits = []
  end

  def bet
    dice = rand(6) + 1

    case dice
      when 1
        @money += 100
        puts "dice 1"
      when 2
        @money /= 2
        puts "dice 2"
      when 6
        fruit = get_fruit
        puts "fruit purchase #{fruit} "
        @fruits << fruit
      else
        puts "no selection"
    end
  end

  def create_memento
    memento = Memento.new(@money)

    @fruits.each do |fruit|
      if /^fruit/ =~ fruit
        memento.add_fruit(fruit)
      end
    end

    return memento
  end

  def restore_memento(memento)
    @money = memento.money
    @fruits = memento.fruits
  end

  def to_s
    return "[money = #{@money}, fruits = #{@fruits}]"
  end

private
  def get_fruit
    prefix = ""

    if rand(2) == 1
      prefix = "おいしい"
    end

    return prefix + @@fruits_name[rand(@@fruits_name.size)]
  end
end

gamer = Gamer.new(100)
memento = gamer.create_memento

100.times do |i|
  puts "==== #{i}"
  puts "fruit: #{gamer}"
  gamer.bet
  puts "fruit #{gamer.money} fruit"

  if gamer.money > memento.money
    puts "（NA）"
    memento = gamer.create_memento
  elsif gamer.money < memento.money / 2
    puts "（less）"
    gamer.restore_memento(memento)
  end

  sleep 1
  puts ""
end

