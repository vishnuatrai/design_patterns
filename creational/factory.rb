#Implementation 
#       should create objects without exposing the instanciation logic to the client
#       should refers to the newly created object through a comman interface.
#           
# 1) The client needs a product, but instead of creating it directly using the new operator, 
# it asks the factory object for a new product, providing the information about the type of 
# object it needs.
# 2) The factory instantiates a new concrete product and then returns to the client the newly 
# created product(casted to abstract product class).
# 3) The client uses the products as abstract products without being aware about their 
# concrete implementation.
#
#[Collaborators]
#       Factory:: {CommandFactory}
#       Products:: {PasteCommand}, {CutCommand}
#       Client:: {Application}
#

class CommandFactory
  def initialize(context)
    @context = context
  end

  def create_command(name)
    if (name == "Paste")
      return PasteCommand.new(@context)
    elsif (name == "Cut")
      return CutCommand.new(@context)
    else
      throw ("Could Not Construct "+name)
    end  
  end
           
end


class PasteCommand
  def initialize(context)

  end
end

class CutCommand
  def initialize(context)

  end
end

class Application
  def initialize(version_control)
    @command = CommandFactory.new('window').create_command('Paste')
  end

  def run
    puts @command.inspect
  end

end


#
# Class Registration - using reflection
#     If you can use reflection, for example in Java or .NET languages, you can register 
#     new product classes to the factory without even changing the factory itself. 
#     For creating objects inside the factory class without knowing the object type we 
#     keep a map between the productID and the class type of the product. In this case 
#     when a new product is added to the application it has to be registered to the factory.
#     This operation doesn't require any change in the factory class code.
#     
#     class ProductFactory
#     {
#       private HashMap m_RegisteredProducts = new HashMap();
#       public void registerProduct (String productID, Class productClass)
#       {
#         m_RegisteredProducts.put(productID, productClass);
#       }
#       public Product createProduct(String productID)
#       {
#         Class productClass = (Class)m_RegisteredProducts.get(productID);
#         Constructor productConstructor = cClass.getDeclaredConstructor(new Class[] { 
#                                                     String.class });
#         return (Product)productConstructor.newInstance(new Object[] { });
#       }
#     }
#     
#
# Class Registration - avoiding reflection
#     We don't want to use reflection but in the same time we want to have a reduced 
#     coupling between the factory and concrete products. Since the factory should be 
#     unaware of products we have to move the creation of objects outside of the factory 
#     to an object aware of the concrete products classes. That would be the concrete 
#     class itself.
#
#     We add a new abstract method in the product abstract class. Each concrete class 
#     will implement this method to create a new object of the same type as itself. 
#     We also have to change the registration method such that we'll register concrete 
#     product objects instead of Class objects.
#
#     abstract class Product
#     {
#       public abstract Product createProduct();
#       ...
#     }
#
#     class OneProduct extends Product
#     {
#       ...
#       static
#       {
#         ProductFactory.instance().registerProduct("ID1", new OneProduct());
#       }
#       public OneProduct createProduct()
#       {
#         return new OneProduct();
#       }
#       ...
#     }
#
#     class ProductFactory
#     {
#       public void registerProduct(String productID, Product p)    {
#         m_RegisteredProducts.put(productID, p);
#       }
#
#       public Product createProduct(String productID){
#         ((Product)m_RegisteredProducts.get(productID)).createProduct();
#       }
#     }
#
# A more advanced solution - Factory design pattern with abstractions(Factory Method)

