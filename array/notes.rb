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
#//
#// `&` method
#//     arr & other_ary --> new_array
#// Compares elements (using `hash` and `eql?` methods), then returns 
#// those elements they have in common 
[ 1, 1, 3, 5 ] & [ 1, 2, 3 ]    #=> [ 1, 3 ]
[ 'a', 'b', 'b', 'z' ] & [ 'a', 'b', 'c' ] #=> [ 'a', 'b' ]

#// `*`
#//     array * int  --> new_array
#//     array * str  --> new_string
#// The `*int` creates a new array that is the old array repeated `int` 
#// times. `*str` is equivalent to `array.join(str)`
[ 1, 2, 3 ] * 3     #=> [ 1, 2, 3, 1, 2, 3, 1, 2, 3 ]
[ 1, 2 ,3 ] * ","   #=> "1,2,3"

#// `+` method
#//     array + other_array    --> new_array
#// Concatenates array and other_array
[ 1, 2, 3 ] + [ 4, 5 ]    #=> [ 1, 2, 3, 4, 5 ]
a = [ "a", "b", "c" ]
c = a + [ "d", "e", "f" ]
c                         #=> [ "a", "b", "c", "d", "e", "f" ]
a                         #=> [ "a", "b", "c" ]
a += [ "d", "e", "f" ]
a                         #=> [ "a", "b", "c", "d", "e", "f" ]

#// `-` method
#//     array - other_array  --> new_array
#// Compares and filters out elements from `array` that are also in 
#// `other_array`. Creates a new array made of elements that remain.
#// Comparisons are made with the `hash` and `eql?` methods
[ 1, 1, 2, 2, 3, 3, 4, 5 ] - [ 1, 2, 4 ] #=> [ 3, 3, 5 ]

#// `<<` method
#//     array << obj  --> array_modified
#// Appends value or object to original array. Returns the original array
#// with updated elements
[ 1, 2 ] << "c" << "d" << [ 3, 4 ] #=> [ 1, 2, "c", "d", [ 3, 4 ] ]

#// `<=>` method
#//     array <=> other_array  --> -1 || 0 || +1 || nill
#// Comprison that returns a numeric value for `array` being less than 
#// `other_array` (-1), equal to (0), or greater than (1). Returns nil if
#// not being compared with an array or if comparison returns nil
[ "a", "a", "c" ] <=> ["a", "b", "c" ]  #=> -1
[ 1, 2, 3, 4, 5, 6 ] <=> [ 1, 2 ]       #=> 1
[ 1, 2 ] <=> [ 1, :two ]                #=> nil

#// `==` method
#//     array == other_array  --> bool
#// Compares equality, meaning to contain the same number elements and have
#// each element equal the corresponding element in `other_array`
[ "a", "c" ] == [ "a", "c", 7 ]      #=> false
[ "a" "c", 7 ] == [ "a", "c", 7 ]    #=> true
[ "a" "c", 7 ] == [ "a", "d", "f" ]  #=> false
[ "a" "c", 7 ] == [ "a", 7, "c" ]    #=> false

#// `[]` method
#//     array[index]  --> obj || nil
#//     array[start, length]  --> new_array || nil
#//     array[range]  --> new_array || nil
#//     slice(index)  --> new_array || nil
#//     slice(start, length)  --> new_array || nil
#//     slice(range)  --> new_array || nil
#// Element reference at given index or range. Returns elements that meet
#// the given index(es).
a = [ "a", "b", "c", "d", "e" ]
a[2] + a[0] + a[1]      #=> "cab"
a[6]                    #=> nil
a[1, 2]                 #=> ["b", "c"]
a[1..3]                 #=> ["b", "c", "d"]
a[4..7]                 #=> ["e"]
a[6..10]                #=> nil
a[-3, 3]                #=> ["c", "d", "e"]

# special cases
a[5]                    #=> nil
a[6, 1]                 #=> nil
a[5, 1]                 #=> []
a[5..10]                #=> []

#// `[] =` method
#//     array[index] = obj  --> obj
#//     array[start, length] = obj or o_array or nil  --> obj || o_ary || nil
#//     array[range] = obj or o_array or nil  --> obj || o_array || nil
#// Various methods of variable assignment. Negative indicies count 
#// backwards. Non-existent indicies extend the array
a = Array.new             #=> []
a[4] = "4"                #=> [nil, nil, nil, nil, "4"]
a[0,3] = ['a', 'b', 'c']  #=> ["a", "b", "c", nil, "4"]
a[1..2] = [ 1, 2 ]        #=> ["a", 1, 2, "c", nil, "4"]
a[0, 2] = "?"             #=> ["?", 2, nil, "4"]
a[0..2] = "A"             #=> ["A", "4"]
a[-1] = "Z"               #=> ["A", "Z"]
a[1..-1] = nil            #=> ["A", nil]
a[1..-1] = []             #=> ["A"]
a[0, 0] = [1, 2]          #=> [1, 2, "A"]
a[3, 0] = "B"             #=> [1, 2, "A", "B"]

#// `any?` method
#//     array.any? {|obj| block}  --> true || false
#// Boolean for whether an array has any elements
a = [1]
a.any?                    #=> true

b = []
b.any?                    #=> false

#// `assoc` method
#//     array.assoc(obj)  --> element_array || nil
#// Compares passed through `obj` with first element of array (using `==`)
#// and returns a match (if found) or nil (if not).
s1 = ["colors", "red", "blue", "green"]
s2 = [ "letters", "a", "b", "c" ]
s3 = "foo"

a = [ s1, s2, s3 ]
a.assoc("letters")    #=> ["letters", "a", "b", "c"]
a.assoc("foo")        #=> nil

#// `at` method
#//     array.at(index)  --> obj || nil
#// Returns the element at `index` or nil if out of range
a = [ "a", "b", "c", "d", "e" ]
a.at(0)     #=> "a"
a.at(-1)    #=> "e"

#// `bsearch` method
#//     array.bsearch {|x| block}  --> elem || nil
#// Uses binary search to find a (single) value that meets the block
#// condition. Since it uses binary search, the array must be sorted
ary = [0, 4, 7, 10, 12]

array.bsearch {|x| x >= 4}    #=> 4
array.bsearch {|x| x >= 6}    #=> 7
array.bsearch {|x| x >= -1}   #=> 0
array.bsearch {|x| x >= 100}  #=> nil

array.bsearch {|x| 1 - x / 4} #=> 4 || 7
array.bsearch {|x| 4 - x / 2} #=> nil

#// `bsearch_index` method
#//     array.bsearch_index {|x| block} --> int || nil
#// The same as above except it returns the index rather than element.
ary = [0, 4, 7, 10, 12]

array.bsearch {|x| x >= 4}    #=> 1
array.bsearch {|x| x >= 6}    #=> 2
array.bsearch {|x| x >= -1}   #=> 0

#// `clear` method
#//     array.clear = []
#// Removes all elements from `array`
a = [ "a", "b", "c", "d", "e" ]
a.clear               #=> []
a                     #=> []

#// `collect` method
#//     array.collect {|item| block}  --> new_array
#//     array.collect  --> an_enumerator
#// Calls the given block on each element of `array`, returns an enumerator
#// if no block given
a = [ "a", "b", "c", "d" ]

a.collect { |x| x + "!" }         #=> ["a!", "b!", "c!", "d!"]
a.map.with_index { |x, i| x * i } #=> ["", "b", "cc", "ddd"]
a                                 #=> ["a", "b", "c", "d"]

#// `collect!` method
#//     array.collect! {|item| block}  --> array_modified
#// Same as above, but destructive of original array
a = [ "a", "b", "c", "d" ]

a.collect! { |x| x + "!" }             #=> ["a!", "b!", "c!", "d!"]
a                                      #=> ["a!", "b!", "c!", "d!"]
a.collect!.with_index { |x,i| x[0..i]} #=> ["", "b", "c!", "d!"]
a                                      #=> ["", "b", "c!", "d!"]

#// `combination` method
#//     array.combination(n) {|c| block}  --> array
#//     array.combination(n)  --> Enumerator
#// Yields all combinations of length `n` and returns the array. Returns an
#// enumerator if called without block.
a = [ 1, 2, 3, 4 ]

a.combination(1).to_a  #=>[[1], [2], [3], [4]]
a.combination(2).to_a  #->[[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
a.combination(3).to_a  #=> [[1,2,3],[1,2,4],[1,3,4],[2,3,4]]
a.combination(4).to_a  #=> [[1,2,3,4]]
a.combination(0).to_a  #=> [[]] // one combination of length 0
a.combination(5).to_a  #=> []  // no combinations of length 5

#// `compact` method
#//     array.compact  --> new_array
#// Returns `self` with nil elements removed
["a", nil, "b", "c", nil, nil].compact   #=> ["a", "b", "c"]

a = [1, 2, nil, nil, 3, 4]
a.compact                                #=> [1, 2, 3, 4]
a                                        #=> [1, 2, nil, nil, 3, 4]

#// `compact!` method
#//     array.compact!  --> array_modified || nil
#// Same as above, but detructive and returns `nil` if no nils to clean
a = [1, 2, nil, nil, 3, 4]

a.compact!                               #=> [1, 2, 3, 4]
a                                        #=> [1, 2, 3, 4]

b = ["a", "b", "c"]
b.compact!                               #=> nil
b                                        #=> ["a", "b", "c"]

#// `concat` method
#//     array.concat(other_array)  --> array_modified
#// Appends elements of `other_array` to `array`
["a", "b"].concat(["c", "d"])   #=> ["a", "b", "c", "d"]
a = [ 1, 2, 3 ]
a.concat([ 4, 5 ])              #=> [1, 2, 3, 4, 5]
a                               #=> [1, 2, 3, 4, 5]

#// `count` method
#//     array.count  --> int
#//     array.count(obj)  --> int
#//     array.count {|item| block}  --> int
#// Counts number of elements in array. If `obj`, then counts elements that
#// equal obj (using `==` method). If block, counts elements for which the
#// block returns true
array = [1, 2, 4, 2]

array.count                     #=> 4
array.count(2)                  #=> 2
array.count(4)                  #=> 1
array.count {|x| x % 2 == 0}    #=> 3

#// `cycle` method
