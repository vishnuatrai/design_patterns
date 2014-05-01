# This implementation offers the interface for creating a family of related objects, without explicitly specifying 
# their classes.
#
#[Problem] There is a an application which needs to run on both Win
#          and OSX platforms. Depending on the platform, the application
#          needs to use the correct type of GUI components, like buttons.
#          If the application knows about all the types of components,
#          it's going to turn messy when a new platform or a new type
#          of component is to be added.
#
#[Solution] Use AbstractFactory pattern to abstract object creation
#           based on the family the object belongs to (Win/OSX).
#           ConcreteFactories - WinFactory and OsxFactory implement
#           methods to return products of their families.
#           WinButton and OsxButtons are the products that belong
#           to Win and OSX families respectively
#
#[Collaborators]
#           AbstractFactory:: {GuiFactory}
#           AbstractProduct:: {AbstractButton}
#           ConcreteFactories:: {WinFactory}, {OsxFactory}
#           ConcreteButtons:: {WinButton}, {OsxButton}
#           Client:: {Application}
#


class GuiFactory
  def create_button
    raise NotImplementedError, "#{self.class.name} does not implement create_button()"
  end

end

class WinFactory < GuiFactory
  def create_button
    return WinButton.new
  end

end

class OsxFactory < GuiFactory
  def create_button
    return OsxButton.new
  end

end

class AbstractButton
  def paint
    raise NotImplementedError, "#{self.class.name} does not implement paint()"
  end

end

class WinButton < AbstractButton
  def paint
    puts "I'm a WinButton"
  end

end

class OsxButton < AbstractButton
  def paint
    puts "I'm an OsxButton"
  end

end

class Application

  def initialize(gui_factory)
    @gui_factory = gui_factory
  end

  def run
    button = @gui_factory.create_button
    button.paint
  end

end


wingui = WinFactory.new
app = Application.new(wingui)
app.run


