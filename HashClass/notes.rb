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

#// # Public class Methods
#//
#// There are forms of instantiation. The following are all equivalent.
Hash["a", 100, "b", 200]           # => {"a"=>100, "b"=>200}
Hash[ [ ["a", 100], ["b", 200] ] ] # => {"a"=>100, "b"=>200}
Hash["a" => 100, "b" => 200]       # => {"a"=>100, "b"=>200}

#// The `Hash.new` object returns an empty hash. As stated above, this
#// can be used to change the default value given for a non-existent
#// key (automatically this is set to `nil`)
h = Hash.new("Go Fish") # sets default to be `Go Fish`

h["a"] = 100
h["b"] = 200
h["a"]             #=> 100
h["b"]             #=> 200
h["c"]             #=> "Go Fish"
h["c"].upcase!     #=> "GO FISH", this `!` alters the default permanently
h["d"]             #=> "GO FISH"
h.keys             #=> ["a", "b"]

# This makees a new default object every time:
h = Hash.new { |hash, key| hash[key] = "Go Fish: #{key}" }
h["c"]             #=> "Go Fish: c"
h["c"].upcase!     #=> "GO FISH: C"
h["d"]             #=> "Go Fish: d"
h.keys             #=> ["c", "d"]

#// `try_convert` attempts to convert into a hash (it itself calls the 
#// `to_h` method). It returns either the successfully converted hash
#// or `nil` if conversion fails
Hash.try_convert({1=>2})    #=> {1=>2}
Hash.try_convert(1=>2)      #=> {1=>2}
Hash.try_convert("1=>2")    #=> nil

#// # Public Instance Methods
#//
#// Subset structure:
#//     hash < other --> true || false
#// It returns `true` if `hash` is a subset of `other`, false otherwise.
h1 = {a:1, b:2}
h2 = {a:2, b:2, c:3}

h1 < h2       #=> true
h2 < h1       #=> false
h1 < h1       #=> false

#// Subset or Equal structure:
#//     hash <= other --> true || false
#// This returns `true` if `hash` is either a subset of or equal to other.
h1 = {a:1, b:2}
h2 = {a:2, b:2, c:3}

h1 <= h2       #=> true
h2 <= h1       #=> false
h1 <= h1       #=> true

#// Equality structure
#//     hash == other --> true || false
#// This is true if both hashes have the same number of keys and if the k-v
#// pairs are equal (as determined by `Object#==`). Order does not matter.
h1 = { "a" => 1, "c" => 2 }
h2 = { 7 => 35, "c" => 2, "a" => 1 }
h3 = { "a" => 1, "c" => 2, 7 => 35 }
h4 = { "a" => 1, "d" => 2, "f" => 35 }

h1 == h2     #=> false
h2 == h3     #=> true, because order is not compared
h3 == h4     #=> false

#// Subset second structure:
#//     hash > other --> true || false
#// Reverse of the previous one, determines if `other` is subset of `hash`
h1 = { a: 1, b: 2 }
h2 = { a: 1, b: 2, c: 3 }

h1 > h2     #=> false
h2 > h1     #=> true
h1 > h1     #=> false

#// Subset or Equivalent second structure:
#//     hash >= other --> true || false
#// Again, reversed. Is true if `other` is subset of or equivalent to `hash`
h1 = { a: 1, b: 2 }
h2 = { a: 1, b: 2, c: 3 }

h1 >= h2     #=> false
h2 >= h1     #=> true
h1 >= h1     #=> true

#// Element reference:
#//     hash[key] --> value
#// Conventional dictionary/hash structure
h = { "a" => 100, "b" => 200 }
h["a"]       #=> 100
h["c"]       #=> nil

#// Element assignment:
#//     hash[key] = value --> value
#// Also conventional
h  = { "a" => 100, "b" => 200 }
h["a"] = 9
h["c"] = 4

h                #=> {"a"=>9, "b"=>200, "c"=>4}
h.store("d", 42) #=> 42
h                #=> {"a"=>9, "b"=>200, "c"=>4, "d"=>42}

#// A key should not have its value changed while being used as a key. An
#// unfrozen string passed in as a key will be duplicated and frozen:
a = "a"
b = "b".freeze
h = { a => 100, b => 200 }

h.key(100).equal? a #=> false
h.key(200).equal? b #=> true

#// any? structure
#//     hash.any? {|key, value| block} --> true || false
#// Functions basically the same as enumerables
h = { a: ant, b: bear, c: cat }
h.any? {|key, word| word.length >= 3 }  #=> true
h.any? {|key, word| word.length >= 4 }  #=> true
{ a: nil, b: true, c: 99 }.any?         #=> true

#// assoc structure
#//     assoc(obj) --> an_array or nil
#// Compares the `obj` with keys and returns an array if found or `nil` for
#// no matches
h = { "colors" => ["red", "blue", "green"], 
      "letters" => ["a", "b", "c"]}

h.assoc("letters")  #=> ["letters", ["a", "b", "c"]]
h.assoc("foo")      #=> nil

#// `clear` method
#//     hash.clear --> {}
h = { "a" => 100, "b" => 200 }  #=> {"a"=>100, "b"=>200}
h.clear                         #=> {}

#// `compare_by_identity` and `compare_by_identity?` methods
#//     hash.compare_by_identity
#//     hash.compare_by_identity? --> true || false
#// Compares a hash's keys and considers equivalents if they have the same
#// objects as the same keys
h1 = { "a" => 100, "b" => 200, :c => "c" }
h1["a"]                     #=> 100

h1.compare_by_identity
h1.compare_by_identity?     #=> true
h1["a".dup]                 #=> nil # different objects
h1[:c]                      #=> "c" # same symbols are all same

#// `default()` method
#//     hash.default(key=nil) --> obj
#// returns the default value as set when instantiated
h = Hash.new                           #=> {}
h.default                              #=> nil
h.default(2)                           #=> nil

h = Hash.new("cat")                    #=> {}
h.default                              #=> "cat"
h.default(2)                           #=> "cat"

h = Hash.new {|h,k| h[k] = k.to_i*10}  #=> {}
h.default                              #=> nil
h.default(2)                           #=> 20

#// `default = ` method
#//     hash.default = obj --> obj
#// sets the default value for a hash
h = { "a" => 100, "b" => 200 }
h.default = "Go Fish"
h["a"]       #=> 100
h["z"]       #=> "Go Fish"

h.default = proc do |hash, key|
  hash[key] = key + key
end

h[2]      #=> #<Proc:0x...>
h["cat"]  #=> #<Proc:0x...>

#// `default_proc` method
#//     hash.default_proc --> #<Proc:0x...> || nil
#// returns the block created in Hash::new or `nil` if it wasn't so
#// instantiated
h = Hash.new {|h,k| h[k] = k*k}  #=> {}
p = h.default_proc               #=> #<Proc:0x...>

a = []                           #=> []
p.call(a, 2)
a                                #=> [nil, nil, 4]

#// `default_proc =` method
#//     hash.default_proc = proc_obj || nil --> proc_obj || nil
h.default_proc = proc do |hash, key|
  hash[key] = key + key
end

h[2]      #=> 4
h["cat"]  #=> "catcat"

#// `delete()` method
#//     hash.delete(key) --> value
#//     hash.delete(key) {|key| block} --> value
#// deletes the k-v pair, returning the value
h = { "a" => 100, "b" => 200 }

h.delete("a")                            #=> 100
h.delete("z")                            #=> nil
h.delete("z") {|el| "#{el} not found"}   #=> "z not found"

#// `delete_if` method
#//     hash.delete_if {|key,value| block} --> hash
#//     hash.delete_if --> an_enumerator
#// deletes every k-v pair for which the block returns `true`
h = { "a" => 100, "b" => 200, "c" => 200 }
h.delete_if {|key, value| key >= "b" } #=> {"a"=>100}

#// `dig()` method
#//     hash.dig(key, ...) --> object
#// extracts the nested value specified by the indexes given in sequence
h = { foo: {bar: {baz: 1}} }

h.dig(:foo, :bar, :baz)       #=> 1
h.dig(:foo, :zot, :xyz)       #=> nil

g = { foo: [10, 11, 12] }
g.dig(:foo, 1)                #=> 11

#// `each` and `each_pair` methods
#//     hash.each {|key, value| block} --> block_output
#//     hash.each_pair {|key, value| block} --> block_output
#//     hash.each --> an_enumerator
#//     hash.each_pair --> an _enumerator
#// Affects every k and or v according to the block or returns an enumerator
#// if no block is given
h = { "a" => 100, "b" => 200 }
h.each {|key, value| puts "#{key} is #{value}"}
# prints:
#     a is 100
#     b is 200
#
#// `each_key` method
#//     hash.each_key {|key| block} --> hash
#//     hash.each_key --> an_enumerator
#// Calls block on each key in hash with `key` as parameter. Returns 
#// enumerator if no block given.
h = { "a" => 100, "b" => 200 }
h.each_key {|key| puts key}
# returns:
#     a
#     b
#
#// `each_pair` method
#// <The same as the `each` and `each_pair` methods above>
h = { "a" => 300, "b" => 200 }
h.each {|key, value| puts "#{key} is #{value}"}
# prints:
#     a is 300
#     b is 200
#
#// `each_value` method
#//     hash.each_value {|value| block} --> hash
#//     hash.each_value --> enumerator
#// Calls block once on each key in `hash` with `value` as parameter. 
#// Returns an enumerator if 
h = { "a" => 100, "b" => 200 }
h.each value {|value| puts value }

#// `empty?` method
#//     hash.empty? --> true || false
#// Self-evident
{}.empty?          #=> true
{a: "ant"}.empty?  #=> false

#// `eql?` method
#//     hash.eql?(other) --> true || false
#// Returns true if the content of `hash` and `other` is the same. Not 
#// compared by order. Examples above.
#
#// `fetch` method
#//     hash.fetch(key [, default]) --> obj
#//     hash.fetch(key) {|key| block} --> obj
#// Returns a value from the hash for the given key or default value if
#// input key is not in the hash
h = { "a" => 100, "b" => 200 }

h.fetch("a")                         #=> 100
h.fetch("z", "go fish")              #=> "go fish"
h.fetch("z") {|el| "go fish, #{el}"} #=> "go fish, z"

#// `fetch_values` method
#//     hash.fetch_values(key, ...) --> array
#//     hash.fetch_values(key, ...) {|key| block} --> array
#// Returns an array of values paired with the given keys, raises a KeyError
#// if even a single key can't be found. Block modifies this.
h = { "cat" => "feline", "dog" => "canine", "cow" => "bovine" }

h.fetch_values("cow", "cat")                  #=> ["bovine", "feline"]
h.fetch_values("cow", "bird")                 # raises KeyError
h.fetch_values("cow", "bird") {|k| k.upcase}  #=> ["bovine", "BIRD"]

#// `flatten` method
#//     hash.flatten --> an_array
#//     hash.flatten(level) --> an_array
#// returns a one-dimensional, flattened version of the hash as an array
a = {1 => "one", 2 => [2, "two"], 3 => "three"}
a.flatten     #=> [1, "one", 2, [2, "two"], 3, "three"]
a.flatten(2)  #=> [1, "one", 2, 2 "two", 3, "three"]

#// `has_key?` method
#//     hash.has_key?(key) --> true || false
#// Returns true if given key is in hash
h = { "a" => 100, "b" => 200 }

h.has_key?("a")  #=> true
h.has_key?("z")  #=> false

#// `has_value?` method
#//     hash.has_value(value) --> true || false
#// returns true if given value is in hash
h = { "a" => 100, "b" => 200 }

h.has_value?(100)    #=> true
h.has_value?(999)    #=> false

#// `hash` method
#//     hash.hash --> fixnum
#// Computes and return a hash-code for the object. Hash codes will be
#// identical for identical hashes.
a = {a: "ant", b: "bat"}
b = {:a => "ant", :b => "bat"}
c = {:a => "ant", :b => "bat", :c => "cat"}

a.hash           #=> 3302772276800231924
b.hash           #=> 3302772276800231924
c.hash           #=> 183772604579862498

a.hash == b.hash #=> true
a.hash == c.hash #=> false
b.hash == c.hash #=> false

#// `include?` method
#//     hash.include?(key) --> true || false
#// Boolean check for given key. Doesn't test for member equality.
h = { "a" => 100, "b" => 200 }

h.include?("a")  #=> true
h.include?("b")  #=> true
h.include?(100)  #=> false
h.include?(200)  #=> false

#// `to_s` and `inspect` method
#//     hash.to_s --> string
#//     hash.inspect --> string
h = { "c" => 300, "a" => 100, "d" => 400, "c" = 300 }
h.to_s  #=> "{\"c\"=>300, \"a\"=>100, \"d\"=>400}"

#// `invert` method
#//     hash.invert --> { v => k }
#// creates a new hash where the values of the original become the keys 
#// of the new and the keys become the values
h = { "n" => 100, "m" => 100, "y" => 300, "d" => 200, "a" => 0 }
h.invert    #=> {0=>"a", 100=>"m", 200=>"d", 300=>"y"}

#// `keep_if` method:
#//     hash.keep_if {|key, value| block} --> hash
#//     hash.keep_if --> an_enumerator
#// Deletes any k-v pair for which the block returns to false. Returns
#// an enumerator if no block given
h = {a: "ant", b: "bear", c: "cat"}

h.keep_if {|k, v| v.length < 4}  #=> {a: "ant", c: "cat"} 

#// `key` method
