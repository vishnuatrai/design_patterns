#Implementation
#       Control write access to class attributes
#       Separate data from methods that use it
#       Encapsulate class data initialization
#       Providing new type of final - final after constructor
#       A class may have one-time mutable attributes that cannot be declared final. Using 
#       this design pattern allows one-time setting of those class attributes.
#       The motivation for this design pattern comes from the design goal of protecting 
#       class state by minimizing the visibility of its attributes (data).
#
#       The private class data design pattern solves the problems above by extracting a 
#       data class for the target class and giving the target class instance an instance of 
#       the extracted data class.
#
#       Create data class. Move to data class all attributes that need hiding.
#       Create in main class instance of data class.
#       Main class must initialize data class through the data class's constructor.
#       Expose each attribute (variable or property) of data class through a getter.
#       Expose each attribute that will change in further through a setter.
#
