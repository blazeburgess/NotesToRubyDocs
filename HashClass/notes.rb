#// Dictionary structure. Also called associative arrays.
#// Can use any object type as an index and enumerates values in the order
#// they were created.
#//
#// Instantiations
grades = { "Jane Doe" => 10, "Jim Doe" => 6 } # implicit creation

options = { :font_size => 10, :font_family => "Arial"  } # symbols as keys

options = { font_size: 10, font_family: "Arial" } # didn't work in irb, 
            #should work the same as above

grades = Hash.new
grades["Dorothy Doe"] = 9

#// Accessing values
grades["Jane Doe"] # => 10
options[:font_size] # => 10

#// Hashes have a default value for accessing keys that do not exist
grades = Hash.new(0) # sets default to `0`

grades = {"Timmy Doe" => 8}
grades.default = 0 # also sets default to `0`
puts grades["Jane Doe"] # => 0

#// ## Common Uses
#// Hashes most easily represent data structures that benefit from having
#// named parameters.
books = {}
books[:matz] = "The Ruby Language"
books[:black] = "The Well-Grounded Rubyist"

#// Another example, highlighting how clean the interface can be:
Person.create(name: "John Doe", age: 27)

def self.create(params)
  @name = params[:name]
  @age = params[:age]
end

#// # Hash Keys
#// When two objects have identical hash values and are `eql?' to each other
#// they have the same hash key
#//
#// A user-defined class can be used by overidding the `hash` and `eql?`
#// methods. Otherwise, separate instances refer to separate keys.
#//
#// Typically a hash is implemented around object data while `eql?` is
#// aliased to the overridden `==` method
class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def ==(other) # set's comparison features
    self.class === other and
      other.author == @author and
      other.title == @title
  end

  alias eql? ==

  def hash
    @author.hash & @title.hash # XOR
  end
end

book1 = Book.new 'matz', 'Ruby in a Nutshell'
book2 = Book.new 'matz', 'Ruby in a Nutshell'

reviews = {}

reviews[book1] = 'Great reference!'
reviews[book2] = 'Nice and Compact!'

reviews.length # => 1
