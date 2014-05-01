# Defines an instance for creating an object but letting subclasses decide which class to instantiate
# Refers to the newly created object through a common interface
# Builder pattern used when -
#        1) the creation algorithm of a complex object is independent from the parts that actually compose the object
#        2) the system needs to allow different representations for the objects that are being built
# 
# Examples
#        Vehicle Manufacturer
#        Students Exams
#
# Builder and Abstract Factory
#        The Builder design pattern is very similar, at some extent, to the Abstract Factory pattern. That's why it 
#        is important to be able to make the difference between the situations when one or the other is used. 
#        In the case of the Abstract Factory, the client uses the factory's methods to create its own objects. 
#        In the Builder's case, the Builder class is instructed on how to create the object and then it is asked 
#        for it, but the way that the class is put together is up to the Builder class, this detail making the 
#        difference between the two patterns.
#
#[Problem] There is a an application which needs to generate different
#          types of emails, say welcome mail or alert mail. There needs
#          to be a way to pick different themes for the same email template.
#          If there are going to be conditionals inside the template classes
#          to create the email template in each theme, it's going to get messy
#          soon when we have lots of email templates and many more themes.
#
#[Solution] Use Builder pattern to separate creation steps and
#           internal representations of complex objects created.
#           Here it means separating the blueprint for creating each
#           type of email template from what theme is used in the email
#           template to create the elements of the email, say subject,
#           body and footer. Thus, any type of theme can be used by
#           any email template, provided all themes have the same
#           interface to create the subject, body and footer of the email.
#
#[Collaborators]
#           AbstractBuilder:: {EmailBuilder}
#           ConcreteBuilder:: {DarkEmailBuilder}, {WhiteEmailBuilder}
#           Director:: {WelcomeEmail}, {AlertEmail}
#           Product:: {Email}
#           Client:: {Application}
#

class EmailBuilder
  attr_accessor :email
  def initialize
    @email = Email.new
  end

  def set_subject
    raise NotImplementedError, "#{self.class.name} does not implement set_subject()"
  end
  
  def set_body
    raise NotImplementedError, "#{self.class.name} does not implement set_body()"
  end
   
  def set_footer
    raise NotImplementedError, "#{self.class.name} does not implement set_footer()"
  end

end

class DarkEmailBuilder < EmailBuilder
  def set_subject(content)
    content = "dark #{content}"
    @email.subject = content
  end

  def set_body(content)
    content = "dark #{content}"
    @email.body = content
  end

  def set_footer(content)
    content = "dark #{content}"
    @email.footer = content
  end

end

class WhiteEmailBuilder < EmailBuilder
  def set_subject(content)
    content = "white #{content}"
    @email.subject = content
  end

  def set_body(content)
    content = "white #{content}"
    @email.body = content
  end

  def set_footer(content)
    content = "white #{content}"
    @email.footer = content
  end

end

class WelcomeEmail
  def initialize(builder)
    @builder = builder
  end

  def create_email
    @builder.set_subject('welcome')
    @builder.set_body('body')
    @builder.set_footer('footer')
  end

end

class AlertEmail
  def initialize(builder)
    @builder = builder
  end

  def create_email
    @builder.set_subject('alert')
    @builder.set_body('body')
    @builder.set_footer('footer')
  end

end

class Email
  attr_accessor :subject, :body, :footer
  def to_s
    [subject, body, footer].join(', ')
  end

end

class Application
  def send_welcome_mail(theme)
    welcome_email = WelcomeEmail.new(theme)
    welcome_email.create_email
    puts theme.email.to_s
  end

  def send_alert_mail(theme)
    alert_email = AlertEmail.new(theme)
    alert_email.create_email
    puts theme.email.to_s
  end

end


