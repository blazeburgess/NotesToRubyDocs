#// # Class
#//
#// Classes are first-class objects, meaning that they are all instances
#// of the `Class` class
#//
#// Typical instantiation
class Name
  # code describing class behavior.
end

#// In the above example, as in every possible instantiation, a class calls
#// upon the `Class` class, which can be demonstrated by overriding 
#// behavior at that level
class Class
  alias old_new new
  def new(*args)
    print "Creating a new ", self.name, "\n"
    old_new(*args)
  end
end

class Name
end          # prints: 
             #     Creating a new RubyToken::TkCLASS
             #     Creating a new RubyToken::TkSPACE
             #     Creating a new RubyToken::TkCONSTANT
             #     Creating a new RubyToken::TkNL

n = Name.new # prints:
             #     Creating a new RubyToken::TkIDENTIFIER
             #     Creating a new RubyToken::TkSPACE
             #     Creating a new RubyToken::TkASSIGN
             #     Creating a new RubyToken::TkSPACE
             #     Creating a new RubyToken::TkCONSTANT
             #     Creating a new RubyToken::TkDOT
             #     Creating a new RubyToken::TkIDENTIFIER
             #     Creating a new RubyToken::TkNL
             #     Creating a new Name
             # returns:
             #     #<Name:0x...>
#// Classes, modules, and objects are all interrelated. All metaclasses are
#// also instances of the `Class` class
#//
#// ## Public Class Methods
#// `new` method
#//     Class.new(super_class=Object) --> a_class
#//     Class.new(super_class=Object) {|mod|...} --> a_class
#// Creates an anonymous class with a given super class. If a block is 
#// given it is passed through the class object and evaluated using
#// class_eval
fred = Class.new do
  def meth1
    "hello"
  end

  def meth2
    "bye"
  end
end

a = fred.new      #=> #<#<Class:0x...>:0x...>
a.meth1           #=> "hello"
a.meth2           #=> "bye"

#// ## Public Instance Methods
#//
#// `allocate` method
klass = Class.new do
  def initialize(*args)
    @initialized = true
  end

  def initialized?
    @initialized || false
  end
end

klass.allocate.initialized?   #=> false  ## my irb returned "undefined"

#// `new` method
#//     Class.new(args, ...) --> obj
#// Calls `allocate` method to create a new object of `class`'s class, then
#// initializes the object through it's `initialize` method
class Person
  def initialize(name, address)
    @name = name
    @address = address
  end
  def say_hello
    puts "hello"
  end
end

jeff = Person.new("Jeffrey Jefferson", "Virginia") #=> #<Person:0x...>

#// superclass
#//     Class.superclass --> a_superclass || nil
File.superclass           #=> IO
IO.superclass             #=> Object
Object.superclass         #=> BasicObject
BasicObject.superclass    #=> nil

class Foo; end
class Bar < Foo; end

Bar.superclass            #=> Foo
Foo.superclass            #=> Object

#// ## Private Instance Methods
#//
#// `inheredted` method
#//    Class.inherited(subclass)
#// Callback invoked whenever subclass is created
class Foo
  def self.inherited(subclass)
    puts "New subclass: #{subclass}"
  end
end

class Bar < Foo
end                  #=> New subclass: Bar

class Baz < Bar
end                  #=> New subclass: Baz
