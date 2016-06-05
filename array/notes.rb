#// # Arrays
#// 
#// Ordered, integer-indexed collections of any object. Indexing begins at
#// 0. Negative indexes are taken as relative references to the end of the
#// array (-1 is the last element, -2 is second to last, ...)
#//
#// ## Creating Arrays
ary = [1, "two", 3.0] #=> [1, "two, 3.0] // literal constructor w/various
               # types of objects [int, str, float]
ary = Array.new       #=> [] // explicit construction
Array.new(3)          #=> [nil, nil, nil]
Array.new(3, true)    #=> [true, true, true]

#// To create an array with separate object simply pass a block instead of
#// a second argument
Array.new(4) { Hash.new }   #=> [ {}, {}, {}, {} ]
empty_table = Array.new(3) { Array.new(3) } #=> [ [nil, nil nil], [nil, nil
                            #   nil], [nil, nil, nil] ]
#// The `Array` method can also be used in the following manner, which calls
#// `to_ary`, then `to_a`
Array({:a => "a", :b => "b"})  #=> [ [:a, "a"], [:b, "b" ] ]

#// ## Accessing Elements
#// Most typical method:
arr = [1, 2, 3, 4, 5, 6]
a[2]        #=> 3
arr[100]    #=> nil
arr[-3]     #=> 4
arr[2, 3]   #=> [3, 4, 5]
arr[1..4]   #=> [2, 3, 4, 5]
arr[1..-3]  #=> [2, 3, 4]
arr[-3..1]  #=> []

#// But the `at(index)` method does the same
arr = [1, 2, 3, 4, 5, 6]
arr.at(0)   #=> 1

#// To raise an error for non-existent indexes, use the fetch function
arr = ['a', 'b', 'c', 'd', 'e', 'f']

arr.fetch(100)      #=> IndexError: index 100 outside of array bounds: -6..6
arr.fetch(100, "oops") #=> "oops"

#// special methods for first and last elements
arr.first  #=> 1
arr.last   #=> 6

#// to return first `n` elements
arr.take(3) #=> [1, 2, 3]

#// to remove the first `n` elements, return the remainder
arr.drop(3) #=> [4, 5, 6]

#// ## Getting information on an array
#// length, count, and size
browsers = ['Chrome', 'Firefox', 'Safari', 'Opera', 'IE']
browsers.length   #=> 5
browsers.count    #=> 5
browsers.size     #=> 5

#// check whether an array has any elements
browsers.empty?

#// check if a particular item is an element in the array
browsers.include('Konqueror')   #=> false

#// ## Adding Items to Arrays
#// `push` and `<<`
#// appends item
arr = [1, 2, 3, 4]
arr.push(5) #=> [1, 2, 3, 4, 5]
arr << 6    #=> [1, 2, 3, 4, 5, 6]

#// `unshift`
#// adds item to beginning
arr = [1, 2, 3, 4, 5, 6]
arr.unshift(0)  #=> [0, 1, 2, 3, 4, 5, 6]

#// `insert`
#//     arr.insert(index, item) --> arr
#// add an item at any index
arr = [0, 1, 2, 3, 4, 5, 6]
arr.insert(3, 'apple') #=> [0, 1, 2, 'apple', 3, 4, 5, 6]

arr.insert(3, 'orange', 'pear', 'grapefruit') #=> [0, 1, 2, 'orange', 
                            #  'pear', 'grapefruit', 'apple', 3, 4, 5, 6]

#// ### Removing Items from Array
#// `pop`
#// removes last item from array, returns that item
arr = [1, 2, 3, 4, 5, 6]
arr.pop        #=> 6
arr            #=> [1, 2, 3, 4, 5]

#// `shift`
#// removes and returns first item from array
arr = [1, 2, 3, 4, 5]
arr.shift      #=> 1
arr            #=> [2, 3, 4, 5]

#// `delete_at`
#// delete an element at a specific index
arr = [2, 3, 4, 5]
arr      #=> [2, 3, 5]

#// `delete`
#// delete a particular element anywhere in the array, any number of times
arr = [1, 2, 2, 3]
arr.delete(2)  #=> 2
arr            #=> [1, 3]

#// `compact` and `compact!`
#// both remove `nil` values and return the array, the latter saves this
#// to the original array
arr = ['foo', 0, nil, 'bar', 7, 'baz', nil]
arr.compact     #=> ['foo', 0, 7, 'baz']
arr             #=> ['foo', 0, nil, 'bar', 7, 'baz', nil]
arr.compact!    #=> ['foo', 0, 7, 'baz']
arr             #=> ['foo', 0, 7, 'baz']

#// `uniq` and `uniq!`
#// non-desctructive and destructive, respectively, methods to remove 
#// duplicate values from an array
arr = [2, 5, 6, 556, 6, 6, 8, 9, 0, 123, 556]
arr.uniq     #=> [2, 5, 6, 556, 8, 9, 0, 123]

#// ## Iterating over Arrays
#//
#// `each` method
#//     arr.each {|val| block}  --> arr
#//     arr.each do |val
#//         #code here
#//     end                     --> arr
#//     arr.each                --> an_enumerator
#// Executes block on the values of `arr`, returns the original arr. If no
#// block given, returns an enumerator.
arr = [1, 2, 3, 4, 5]

arr.each { |a| print a -= 10, " "}  # prints: "-9 -8 -7 -6 -5"
                                    #=> [1, 2, 3, 4, 5]
arr.each do |a|
  print a -= 10, " "
end                                 # equivalent statement

arr.each                            #=> #<Enumerator: [1, 2, 3, 4, 5]:each>

arr                                 #=> [1, 2, 3 , 4 ,5]

#// `reverse_each` method
#//     arr.reverse_each {|val| block}    --> arr
#//     arr.reverse_each                  --> an_enumerator
#// Iterates over the array in reverse order
words = %w[first second third fourth fifth sixth]
words           #=> ["first", "second", "third", "fourth", "fifth", "sixth"]

str = ""
words.reverse_each { |word| str +=  "#{word} " }
str        #=> "sixth fifth fourth third second first"

#// `map` and `map!` method
#//      arr.map { |val| block }    --> new_array
#//      arr.map! { |val| block }   --> modified_arr
#//      arr.map                    --> enumerator
#// Non-destructive and destructive, respectively, method to return a new
#// array with values modified by the block statement. If no block given,
#// returns an enumerator
arr = [1, 2, 3, 4, 5]

arr.map { |a| 2*a }      #=> [2, 4, 6, 8, 10]
arr                      #=> [1, 2, 3, 4, 5]
arr.map! { |a| a**2 }    #=> [1, 4, 9, 16, 25]
arr                      #=> [1, 4, 9, 16, 25]

#// ## Selecting Items from an Array
#//
#// Non-destructive selection
arr = [1, 2, 3, 4, 5, 6]
arr.select { |a| a > 3 }     #=> [4, 5, 6]
arr.reject { |a| a < 3 }     #=> [3, 4, 5, 6]
arr.drop_while { |a| a < 4 } #=> [4, 5, 6]

arr                          #=> [1, 2, 3, 4, 5, 6]

#// Destructive selection
arr = [1, 2, 3, 4, 5, 6]
arr.delete_if { |a| a < 4 }  #=> [4, 5, 6]
arr                          #=> [4, 5, 6]

arr = [1, 2, 3, 4, 5, 6]
arr.keep_if { |a| a < 4 }    #=> [1, 2, 3]
arr                          #=> [1, 2, 3]

arr = [1, 2, 3, 4, 5, 6]
arr.select! { |a| a > 2 }    #=> [3, 4, 5, 6]
arr                          #=> [3, 4, 5, 6]

arr = [1, 2, 3, 4, 5, 6]
arr.reject! { |a| a > 2 }    #=> [1, 2]

#// ## Public Class Methods
#// `[]` method
#//     Array.[](*args)  --> new_array
#// Creates and populates a new array with given `args`
Array.[](1, 'a', /^A/)       #=> [1, "a", /^A/]
Array[ 1, 'a', /^A/ ]        #=> [1, "a", /^A/]
[ 1, 'a', /^A/ ]             #=> [1, "a", /^A/]

#// `new` method
#//     Array.new(size=0, default=nil)     --> an_array
#//     Array.new(array)                   --> array
#//     Array.new(size) {|index| block}    --> an_array
#//     Array.new                          --> []
#// Creates and populates an array according to inputs
first_array = ["Matz", "Guido"]
second_array = Array.new(first_array)#=> ["Matz", "Guido"]
first_array.equal? second_array      #=> false // b/c s_a is a copy
Array.new(3) { |index| index ** 2 }  #=> [0, 1, 4]

#// The second parameter in `new` creates the same object, which can lead
#// to assignment issues
a = Array.new(2, Hash.new)           #=> [ {}, {} ]
a[0]['cat'] = 'feline'
a                                    #=>[{"cat"=>"feline"},{"cat"=>"feline}]
a[1]['cat'] = 'Felix'
a                                    #=>[{"cat"=>"Felix"},{"cat"=>"Felix"}]

#// To avoid these assignment issues, simply use the block form
a = Array.new(2) { Hash.new }
a[0]['cat'] = 'feline'
a                                    #=> [{"cat"=>"feline"}, {}]

#// `try_convert` method
#//     Array.try_convert(obj)  --> array || nil
#// attempts to convert the object to an array, returns that array if
#// successful, returns nil if it fails
Array.try_convert([1])      #=> [1]
Array.try_convert("1")      #=> nil

if tmp = Array.try_convert(arg)
  # the argument is an array
elsif tmp = String.try_convert(arg)
  # the argument is a string
end

#// ## Public Instance Methods

