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
#//     array.cycle(n=nil) {|obj| block}  --> nil
#//     array.cycle(n=nill)  --> Enumerator
#// Calls given block on each element `n` number of times
a = ["a", "b", "c"]

a.cycle {|x| puts x}      # prints: a, b, c, a, b, c, a, b... forever.
a.cycle(2) {|x| puts x}   # prints: a, b, c, a, b, c

#// `delete` method
#//     array.delete(obj)  --> item || nil
#//     array.delete(obj) {block}  --> item || block_result
#// Deletes all items from `array` that are equal to `obj`. If not found
#// it returns nil (or the contents of the block, if given).
a = ["a", "b", "b", "b", "c"]

a.delete("b")                 #=> "b"
a                             #=> ["a", "c"]

a.delete("z")                 #=> nil
a.delete("z") {"not found"}   #=> "not found"

#// `delete_at` method
#//     array.delete_at(index)  --> obj || nil
#// Deletes and returns element at specified index
a = ["ant", "bat", "cat", "dog"]

a.delete_at(2)                   #=> "cat"
a                                #=> ["ant", "bat", "dog"]

a.delete_at(99)                  #=> nil

#// `delete_if` 
#//     array.delete_if {|item| block}  --> array_array
#//     array.delete_if  --> Enumerator
#// Deletes every element for which block returns true, returns modified
#// array. Returns enumerator if no block given.
scores = [ 97, 42, 75 ]
scores.delete_if {|score| score < 80 }   #=> [97]
scores                                   #=> [97]

#// `dig` method
#//     array.dig(index, ...)  --> obj
#// Calls indicies in sequence on `array` and returns object when found. 
#// Returns nil if any step is nil 
a = [ [ 1, [2, 3] ] ]

a.dig(0, 1, 1)                          #=> 3  // my irb returns undefined
a.dig(1, 2, 3)                          #=> nil
a.dig(0, 0, 0)                          #=> NoMethodError, undefined

[42, {foo: :bar}].dig(1, :foo)          #=> :bar

#// `drop` method
#//     array.drop(n)  --> new_array
#// Deletes first `n` elements from array, returns the remainder
a = [1, 2, 3, 4, 5, 0]

a.drop(3)                               #=> [4, 5, 0]
a                                       #=> [1, 2, 3, 4, 5, 0]

#// `drop_while` method
#//     array.drop_while {|obj| block}  --> new_array
#//     array.drop_while  --> Enumerator
#// Drops elements up to (non-inclusive) the first element for which the 
#// block returns nil or false. Returns an array of the remaining elements
a = [1, 2, 3, 4, 5, 0]

a.drop_while {|i| i < 3}                #=> [3, 4, 5, 0]
a                                       #=> [1, 2, 3, 4, 5, 0]

#// `each` method
#//     array.each {|item| block}  --> array
#//     array.each  --> Enumerator
#// Calls the block on each element one with the element as parameter.
a = ["a", "b", "c"]

a.each {|x| print x, " -- "} # prints: "a -- b -- c --"
                             #=> ["a", "b", "c"]

#// `each_index` method
#//    array.each_index {|index| block}  --> array
#//    array.each_index  --> Enumerator
#// Same as each, but passes index (instead of element) as parameter
a = [ "a", "b", "c" ]
a.each_index {|x| print x, " -- "} # prints: "0 -- 1 -- 2 -- "
                                   #=> ["a", "b", "c"]

#// `empty?` method
#//     array.empty?  --> true || false
#// Returns boolean value for whether or not `array` has no elements
[].empty?                    #=> true
[3].empty?                   #=> false

#// `eql?` method
#//     array.eql?(other_array)  --> true || false
#// Returns boolean whether `array` and `other_array` are the same object
a = [ 1, 2, 3 ]

b = a
a.eql?(b)                   #=> true

b = [ 1, 2, 3 ]
a.eql?(b)                   #=> true

b = [ 3, 2, 1 ]
a.eql?(b)                   #=> false

b = [ 1, 3 ]
a.eql?(b)                   #=> false

b = "string"
a.eql?(b)                   #=> false

#// `fetch` method
#//     array.fetch(index)  --> obj
#//     array.fetch(index, default)  --> obj
#//     array.fetch(index) {|index| block}  --> obj
#// Attempts to return the element at `array`[`index`]. Throws IndexError
#// if given index is out of bounds. This can be overridden by adding
#// a second argument that acts as default. Block, if given, is referenced
#// only when an invalid index is given.
a = [ 11, 22, 33, 44 ]

a.fetch(1)                                      #=> 22
a.fetch(-1)                                     #=> 44
a.fetch(4, 'cat')                               #=> "cat"
a.fetch(100) {|i| put "#{i} is out fo bounds"}  #=> "100 is out of bounds"

#// `fill` method
#//     array.fill(obj)  --> array
#//     array.fill(obj, start [, length])  --> array
#//     array.fill(obj, range)  --> array
#//     array.fill {|index| block}  --> array
#//     array.fill(start [, length]) {|index| block}  --> array
#//     array.fill(range {|index| block}  --> array
#// First three above assign selected elements of `array` to `obj`. (`start`
#// = nil) == (`start` = 0). (length = nil) == (length = array.length)
#// Last three fill the array with the value of the given block, which
#// takes the absolute index as parameter.
a = [ "a", "b", "c", "d" ]

a.fill("x")                               #=> ["x", "x", "x", "x"]
a.fill("z", 2, 2)                         #=> ["x", "x", "z", "z"]
a.fill("y", 0..1)                         #=> ["y", "y", "z", "z"]
a.fill { |i| i * i }                      #=> [0, 1, 4, 9]
a.fill(-2) {|i| i * i * i }               #=> [0, 1, 8, 27]

#// `find_index` method
#//     array.find_index(obj)  --> int || nil
#//     array.find_index {|item| block}  --> int || nil
#//     array.find_index  --> Enumerator
#// Returns the index of the first object in `array` that is `==` `obj`
a = [ "a", "b", "c" ]

a.find_index("b")                         #=> 1
a.find_index("z")                         #=> nil
a.find_index {|x| x == "b" }              #=> 1

#// `first` method
#//     array.first  --> obj || nil
#//     array.first(n)  --> new_array
#// Returns first element or first `n` elements of `array`
a = [ "q", "r", "s", "t" ]

a.first                                  #=> "q"
a.first(2)                               #=> ["q", "r"]

#// `flatten` method
#//     array.flatten  --> new_array
#//     array.flatten(level)  --> new_array
#// Returns a one-dimensional array by recursively flattening nested arrays
s = [ 1, 2, 3 ]
t = [ 4, 5, 6, [7, 8 ] ]

a = [ s, t, 9, 10 ]                     #=> [[1,2,3],[4,5,6,[7,8]],9,10]
a.flatten                               #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
a                                       #=> [[1,2,3],[4,5,6,[7,8]],9,10]

a = [ 1, 2, [3, [4, 5] ]                #=> [1, 2, [3, [4, 5]]]
a.flatten(1)                            #=> [1, 2, 3, [4, 5]]
a.flatten(2)                            #=> [1, 2, 3, 4, 5]
a                                       #=> [1, 2, [3, [4, 5]]]

#// `flatten!` method
#//     array.flatten!  --> array || nil
#//     array.flatten!(level)  --> array || nil
#// Destructively flattens array, returns itself in modified form
a = [ 1, 2, [3, [4, 5] ]                #=> [1, 2, [3, [4, 5]]]
a.flatten!(1)                           #=> [1, 2, 3, [4, 5]]
a                                       #=> [1, 2, 3, [4, 5]]

a = [ 1, 2, [3, [4, 5] ]
a.flatten!(2)                           #=> [1, 2, 3, 4, 5]
a                                       #=> [1, 2, 3, 4, 5]

#// `frozen?` method
#//     array.frozen?  --> true || false
#// Returns boolean for whether or not the array is frozen (cannot be 
#// modified)
a = [1, 2, 3]
a.frozen?                               #=> false
a.push(4, 5, 6)                         #=> [1, 2, 3, 4, 5, 6]

a.freeze                                #=> [1, 2, 3, 4, 5, 6]
a.frozen?                               #=> true
a.push(7, 8, 9)                         #=> RuntimeError: Can't modify 
                                        # frozen Array

#// `hash` method
#//     array.hash  --> fixnum
#// Computes and returns a hash code for the array. Two arrays with the same
#// content will have the same hash code.
a = [1, 2, 3]
a.hash                                  #=> -1120786499564221288

b = [4, 5, 6]
b.hash                                  #=> 4595764640030203890

a.hash == [1, 2, 3].hash                #=> true

#// `include` method
#//     array.include?(obj)  --> true || false
#// Returns boolean whether or not `obj` is present in `array`
a = ["a", "b", "c"]

a.include?("b")                         #=> true
a.include?("z")                         #=> false

#// `index` method
#//     array.index(obj)  --> int || nil
#//     array.index {|index| block}  --> int || nil
#//     array.index  --> Enumerator
#// Returns index of the first element of `array` that is == `obj`. If block
#// the index of the first element for which the block evaluates true. If no
#// block or argument, returns enumerator
a = ["a", "b", "c"]

a.index("b")                            #=> 1
a.index("z")                            #=> nil
a.index {|x| x=="c"}                    #=> 2

#// `initialize_copy` method
#//     array.initialize_copy(other_array)  --> array
#// Replaces content of `array` with that of `other_array`. If lengths are
#// not equal, it truncates or expands `array` accordingly. Returns modified
#// array.
a = %w[a b c d e]                       #=> ["a", "b", "c", "d", "e"]

# On my irb, this returns
#     NoMethodError: private method `initialize_copy` called
a.initialize_copy(%w[x y z])            #=> ["x","y","z"]
a                                       #=> ["x", "y", "z"]

#// `insert` method
#//     array.insert(index, obj..)  --> array
#// Inserts given values before element with given index.
a = %w{ a b c d }

a.insert(2, 99)                   #=> ["a", "b", 99, "c", "d"]
a.insert(-2, 1, 2, 3)             #=> ["a", "b", 99, "c", 1, 2, 3, "d"]
a = %w{ a b c d }
a.insert(6, "e")                  #=> ["a", "b", "c" "d", nil, nil, "e"]

#// `inspect` method
#//     array.inspect  --> string
#//     array.to_s     --> string
#// Returns a string representation of the array
[ "a", "b", "c" ].inspect         #=> "[\"a\", \"b\", \"c\"]

[ "a", "b", "c" ].to_s            #=> "[\"a\", \"b\", \"c\"]

#// `join` method
#//     array.join(separator=$,)  --> string
#// Creates and returns a string representation of array elements separated
#// by the given separator (defaults to none)
%w[ a b c ].join                  #=> "abc"
%w[ a b c ].join("-")             #=> "a-b-c"

#// `keep_if` method
#//     array.keep_if {|item| block}  --> array
#//     array.keep_if  --> Enumerator
#// Deletes every element in `array` unless it meets block conditions, 
#// returns enumerator if no block given.
a = %w{ a b c d e f }

a.keep_if {|v| v =~ /[aeiou]/}    #=> ["a", "e"]
a                                 #=> ["a", "e"]

#// `last` method
#//     array.last  --> obj || nil
#//     array.last(n)  --> new_array
#// Returns the last or last `n` elements of an array. Returns nil if array
#// is empty
a = %w[ w x y z ]

a.last                            #=> "z"
a.last(2)                         #=> ["y", "z"]

#// `length` method
#//     array.length  --> int
#// Returns number of elements in `array`
[ 1, 2, 3, 4, 5 ].length          #=> 5
[].length                         #=> 0

#// `map` method
#//     array.map {|item| block}  --> new_array
#//     array.map  --> Enumerator
#// Calls the block on each element of `array` once, returns new array of
#// modified values
a = %w[ a b c d ]

a.map {|x| x + "!"}               #=> ["a!", "b!", "c!", "d!"]
a.map.with_index {|x,i| x * i}    #=> ["", "b", "cc", "ddd"]
a                                 #=> ["a", "b", "c", "d"]

#// `map!` method
#//     array.map! {|item| block}  --> array
#//     array.map!  --> Enumerator
#// Same as `map` method, but destructive of the original
a = %w[ a b e f ]

a.map! {|x| x + "!"}              #=> ["a!", "b!", "e!", "f!"]
a                                 #=> ["a!", "b!", "e!", "f!"]

#// `pack` method
#//     array.pack(template_string)  --> binary_string
#// Packs contents of `array` into a binary string via the `template_string`
a = %w[ a b c ]
n = [ 65, 66, 67 ]

a.pack('A3A3A3')                  #=> "a b c "
a.pack("a3a3a3")                  #=> "a\000\000b\000\000c\000\000"

n.pack("ccc")                     #=> "ABC"

#// `permutation` method
#//     array.permutation {|p| block}  --> array
#//     array.permutation  --> Enumerator
#//     array.permutation(n) {|p| block}  --> array
#//     array.permutation(n)  --> Enumerator
#// Yields all permutations (combinations) of n length.
a = [1, 2, 3]

a.permutation.to_a                #=> [[1, 2, 3], [1, 3, 2], [2, 1, 3], 
                                  # [2, 3, 1], [3, 1, 2], [3, 2, 1]]
a.permutation(1).to_a             #=> [[1], [2], [3]]
a.permutation(2).to_a             #=> [[1, 2], [1, 3], [2, 1], [2, 3], 
                                  # [3, 1], [3, 2]]

a.permutation(3).to_a             #=> [[1, 2, 3], [1, 3, 2], [2, 1, 3], 
                                  # [2, 3, 1], [3, 1, 2], [3, 2, 1]]
a.permutation(0).to_a             #=> [ [] ]
a.permutation(4).to_a             #=> []
        # Note: No idea how including a block changes the result. It comes
        #   to the same result no matter if I treat the block as a boolean
        #   or a modifier

#// `pop` method
#//     array.pop  --> obj || nil
#//     array.pop(n)  --> new_array
#// Removes and returns last element or last `n` elements from an array (nil
#//if array is empty.
a = %w[ a b c d ]

a.pop                             #=> "d"
a.pop(2)                          #=> ["b", "c"]
a                                 #=> ["a"]

#// `product` method
#//     array.product(other_array, ...)  --> new_array
#//     array.product(other_array, ...) {|p| block}  --> array
#// Returns an array of all combinations of elements from mixing both 
#// arrays. Length of the returned array is a product of of the length of 
#// `array` and `other_array`
[1, 2, 3].product([4, 5])         #=> [[1,4],[1,5],[2,4],[2,5],[3,4],[3,5]]
[1, 2].product([1, 2])            #=> [[1,1],[1,2],[2,1],[2,2]]
[1, 2].product([3, 4],[5,6])      #=> [[1,3,5],[1,3,6],[1,4,5],[1,4,6],
                                  # [2,3,5],[2,3,6],[2,4,6]]
[1,2].product()                   #=> [[1],[2]]
[1,2].product([])                 #=> []

#// `push` method
#//     array.push(obj, ...)  --> array
#// Appends object(s) to `array
a = %w[ a b c ]

a.push("d", "e", "f")             #=> ["a","b","c","d","e","f"]
[1, 2, 3].push(4).push(5)         #=> [1, 2, 3, 4, 5]
[1, 2, 3].push(4, 5, 6)           #=> [1, 2, 3, 4, 5, 6]

#// `rassoc` method
#//     array.rassoc(obj)  --> element_array || nil
#// Searches through array and compares `obj` with each element (`==` 
#// method). Returns first instance of a match
a = [ [1, "one"], [2, "two"], [3, "three"], ["ii", "two"] ]

a.rassoc("two")                   #=> [2, "two"]
a.rassoc("four")                  #=> nil

#// `reject` method
#//     array.reject {|item| block}  --> new_array
#//     array.reject  --> Enumerator
#// Returns a new array of items for which the block evaluates false
a = [1, 2, 3, 4, 5]

a.reject {|n| n % 2 == 0 }        #=> [1, 3, 5]
a                                 #=> [1, 2, 3, 4, 5]

#// `reject!` method
#//     array.reject! {|item| block}  --> array || nil
#//     array.reject!  --> Enumerator
#// Same as above, but is destructive
a = [1, 2, 3, 4, 5]

a.reject! {|n| n % 2 == 0 }       #=> [1, 3, 5]
a                                 #=> [1, 3, 5]

#// `repeated_combination`
#//     array.repeated_combination(n) {|c| block}  --> array
#//     array.repeated_combination(n)  --> Enumerator
#// Yields all repeated combinations of length `n` elements from the array
#// and returns the array itself.
a = [1, 2, 3]

a.repeated_combination(1).to_a  #=> [[1], [2], [3]]
a.repeated_combination(2).to_a  #=> [[1,1],[1,2],[1,3],[2,2],[2,3][3,3]]
a.repeated_combination(3).to_a  #=> [[1,1,1],[1,1,2],[1,1,3],[1,2,2],[1,2,
                    # 3],[1,3,3],[2,2,2],[2,2,3],[2,3,3],[3,3,3]]
a.repeated_combination(4).to_a  #=> [[1,1,1,1],[1,1,1,2],[1,1,1,3],[1,1,2,
                    # 2],[1,1,3,3],[1,2,2,2],[1,2,2,3],[1,2,3,3],[1,3,3,3],
                    # [2,2,2,2],[2,2,2,3],[2,2,3,3],[2,3,3,3],[3,3,3,3]]
a.repeated_combination(0).to_a  #=> [ [] ]  // one combination fo lenth 0

#// `repeated_permutation`
#//     array.repeated_permutation(n) {|p| block}  --> array
#//     array.repeated_permutation(n)  --> Enumerator
#// Yields repeated permutations of length `n`.
a = [1, 2]

a.repeated_permutation(1).to_a  #=> [[1],[2]]
a.repeated_permutation(2).to_a  #=> [[1,1],[1,2],[2,1],[2,2]]
a.repeated_permutation(3).to_a  #=> [[1,1,1],[1,1,2],[1,2,1],[1,2,2],
                       # [2,1,1],[2,1,2],[2,2,1],[2,2,2]]
a.repeated_permutation(0).to_a  #=> [ [] ]  // one permutation of length 0

#// `replace` method
#//     array.replace(other_array)  --> array
#// Reaplces contents of `array` with those of `other_array`
a = %w[ a b c d e ]

a.replace([ "x", "y", "z" ])    #=> ["x", "y", "z"]
a                               #=> ["x", "y", "z"]

#// `reverse` method
#//     array.reverse  --> new_array
#// Creates and returns an array of `array`'s elements, but in reverse order
[ "a", "b", "c" ].reverse       #=> ["c", "b", "a"]
[ 1 ].reverse                   #=> [1]

#// `reverse!` method
#//     array.reverse!  --> array_modified
#// Same as last except destructive
a = [ "a", "b", "c" ]

a.reverse!                      #=> ["c", "b", "a"]
a                               #=> ["c", "b", "a"]

#// `reverse_each` method
#//     array.reverse_each {|item| block}  --> array
#//     array.reverse_each  --> Enumerator
#// Same as `each`, but goes through `array` in reverse order
a = ["a", "b", "c"]

a.reverse_each {|x| print x, " -- "} # prints: "c -- b -- a -- "

#// `rindex` method
#//     array.rindex(obj)  --> int || nil
#//     array.rindex {|item| block}  --> int || nil
#//     array.rindex  --> Enumerator
#// Returns the index of the last element in `array` to equal `obj` or 
#// have the block return `true`
a = [ "a", "b", "b", "b", "c" ]

a.rindex("b")                   #=> 3
a.rindex("z")                   #=> nil
a.rindex { |x| x == "b" }       #=> 3

#// `rotate` method
#//     array.rotate(count=1)  --> new_array
#// Returns a new array by rotating `array` according to the count. If the 
#// count is negative, it rotates in reverse order
a = %w[ a b c d ]

a.rotate                        #=> ["b", "c", "d", "a"]
a                               #=> ["a", "b", "c", "d"]
a.rotate(2)                     #=> ["c", "d", "a", "b"]
a.rotate(-3)                    #=> ["b", "c", "d", "a"]

#// `rotate!` method
#//     array.rotate!(count = 1)  --> new_array
#// Same as above, but destructive
a = [ "a", "b", "c", "d" ]

a.rotate!                       #=> ["b", "c", "d", "a"]
a                               #=> ["b", "c", "d", "a"]
a.rotate!(2)                    #=> ["d", "a", "b", "c"]
a.rotate!(-3)                   #=> ["a", "b", "c", "d"]

#// `sample` method
#//     array.sample  --> obj
#//     array.sample(rarndom: rng)  --> obj
#//     array.sample(n)  --> new_array
#//     array.sample(n, random: rng)  --> new_array
#// Chooses a random element or `n` random elements from the array
a = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]

a.sample                        #=> 7
a.sample(4)                     #=> [6, 4, 2, 5]

#// `select` method
#//     array.select {|item| block} --> new_array
#//     array.select  --> new_array
#// Returns an array of elements from `array` for which the block evaluates
#// true
[1,2,3,4,5].select { |num| num.even? }  #=> [2, 4]

a = %w{ a b c d e f }

a.select { |v| v =~ /[aeiou]/ }         #=> ["a", "e"]
a                                       #=> ["a", "b", "c", "d", "e", "f"]

#// `select!` method
#//     array.select! {|item| block} --> new_array
#//     array.select!  --> new_array
#// Same as above, but destructive
a = %w[ a b c d e f ]

a.select { |v| v =~ /[aeiou]/ }         #=> ["a", "e"]
a                                       #=> ["a", "e"]

#// `shift` method
#//     array.shift  --> obj || nil
#//     array.shift(n)  --> new_array
#// Removes the first element from `array`, returns the rest. Returns nil
#// if array is empty
args = [ "-m", "-q", "filename" ]

args.shift                          #=> "-m"
args                                #=> ["-q", "filename"]

args = [ "-m", "-q", "filename" ]

args.shift(2)                       #=> ["-m", "-q"]
args                                #=> ["filename"]

#// `shuffle` method
#//     array.shuffle  --> new_array
#//     array.shuffle(random: rng)  --> new_array
#// Creates and returns an array of `array`'s elements randomly shuffled
a = [ 1, 2, 3 ]

a.shuffle                          #=> [1, 3, 2]   // the output varies
a                                  #=> [1, 2, 3]



#// `shuffle!` method
#//     array.shuffle!  --> new_array
#//     array.shuffle!(random: rng)  --> new_array
#// Same as above, but destructive
a = %w[ a b c ]

a.shuffle!                         #=> ["b", "a", "c"] // output varies
a                                  #=> ["b", "a", "c"]

#// `size` method
#//     array.size()  --> fixnum
#// Alias for `length` method. Can be called with or w/o `()`s
[1, 2, 3].size                     #=> 3

a = %w[ a b c d e f ]
a.size()                           #=> 6

#// `slice` method
#//     array.slice(index)  --> obj || nil
#//     array.slice(start, length)  --> new_array || nil
#//     array.slice(range)  --> new_array || nil
#// Returns element at `index` or sub-array from `start` to `length` (or 
#// `range`). Returns nil for nonexistent indices
a = %w[ a b c d e ]

a.slice(2) + a.slice(0) + a.slice(1)    #=> "cab
a                                       #=> ["a", "b", "c", "d", "e"]

a.slice(1, 3)                           #=> ["b", "c", "d"]
a.slice(1..2)                           #=> ["b", "c"]
a.slice(6..10)                          #=> nil
a                                       #=> ["a", "b", "c", "d", "e"]

#// `slice!` method
#//     array.slice!(index)  --> obj || nil
#//     array.slice!(start, length)  --> new_array || nil
#//     array.slice!(range)  --> new_array || nil
#// Same as above, but deletes returned element from `array`
a = ["a", "b", "c"]

a.slice!(1)                       #=> "b"
a                                 #=> ["a", "c"]

a.slice!(-1)                      #=> "c"
a                                 #=> ["a"]

a.slice(100)                      #=> nil
a                                 #=> ["a"]

#// `sort` method
#//     array.sort  --> new_array
#//     array.sort {|a, b| block}  --> new_array
#// Returns a new array from sorting `array`'s elements. Comparisons are 
#// made with the `<=>` operator
a = [ "d", "a", "e", "c", "b" ]

a.sort                            #=> ["a", "b", "c", "d", "e"]
a.sort { |x,y| y <=> x }          #=> ["e", "d", "c", "b", "a"]
a                                 #-> ["d", "a", "e", "c", "b"]

#// `sort!` method
#//     array.sort!  --> new_array
#//     array.sort! {|a, b| block}  --> new_array
#// Same as above, but destructive
a = ["d", "a", "e", "c", "b"]

a.sort!                           #=> ["a", "b", "c", "d", "e"]
a                                 #=> ["a", "b", "c", "d", "e"]

#// `sort_by!` method
#//     array.sort_by! {|obj| block}  --> array
#//     array.sort_by!  --> Enumerator
#// Sorts arraay by using a set of keys made by mapping `array`'s values
#// through the given block.
a = ["c", "e", "b", "d", "a"]


               # Note: Don't really understand this one. 
               #   Will have to revise later. No block I
               #   give it returns a result that makes 
               #   sense given the above definition.

#// `take` method
#//     array.take(n)  --> new_array
#// Returns first `n` elements of the array
a = [1, 2, 3, 4, 5, 0]

a.take(3)                       #=> [1, 2, 3]

#// `take_while` method
#//     array.take_while {|obj| block}  --> new_array
#//     array.take_while  --> Enumerator
#// Returns elements from `array` from index 0 until the block evaluates
#// false.
a = [1, 2, 3 , 4, 5, 0]

a.take_while { |i| i < 3 }      #=> [1, 2]
a.take_while { |i| i < 1 }      #=> []

#// `to_a` method
#//     array.to_a  --> array
#// Returns original array. If called on subclass of Array, reverts class
#// to Array.
[1, 2, 3].to_a                  #=> [1, 2, 3]

#// `to_ary` method
#//     array.to_ary  --> array
#// Returns original array. If called on subclass of Array, reverts class
#// to Array.
[1, 2, 3].to_ary                  #=> [1, 2, 3]

#// `to_h` method
#//     array.to_h  --> hash
#// Returns a hash interpretation of array, converting into k-v pairs
[[:foo, :bar], [1, 2]].to_h       #=> {:foo => :bar, 1 => 2}

["one", 1, "two", 2].to_h         #=> TypeError: wrong element type
[1, 1, 2, 2].to_h                 #=> TypeError: wrong element type

#// `to_s` method
#//     array.to_s  --> string
#// Alias for `inspect`
[1, 2, 3].to_s                             #=> "[1, 2, 3]"
["a", "b", "c", "d", "e", "f", "g"].to_s() #=> "[\"a\", \"b\", \"c\", 
                          # \"d\", \"e\", \"f\", \"g\"]"

#// `transpose` method
#//     array.transpose  --> new_array
#// Assumes `array` is an array of arrays and transposes rows and columns
a = [[1,2], [3,4], [5,6]]
a.transpose                      #=> [ [1, 3, 5], [2, 4, 6] ]

#// `uniq` method
#//     array.uniq  --> new_array
#//     array.uniq {|item| ...}  --> new_array
#// Removes duplicate values and returns new array of the remainder
a = [ "a", "a", "b", "b", "c" ]
a.uniq                          #=> ["a", "b", "c"]
a                               #=> ["a", "a", "b", "b", "c"]

b = [["student", "sam"], ["student", "george"], ["teacher", "matz"]]
b.uniq {|s| s.first}            #=> [["student","sam"],["teacher","matz"]]

#// `uniq!` method
#//     array.uniq!  --> new_array
#//     array.uniq! {|item| ...}  --> new_array
#// Same as above, but destructive
a = [ "a", "a", "b", "b", "c", "d", "d" ]

a.uniq!                         #=> ["a", "b", "c", "d"]
a                               #=> ["a", "b", "c", "d"]

#// `unshift` method
#//     array.unshift(obj, ...)  --> array
#// Prepends objects to `array`
a = [ "b", "c", "d" ]

a.unshift("a")                  #=> ["a", "b", "c", "d"]
a.unshift(1, 2)                 #=> [1, 2, "a", "b", "c", "d"]

#// `values_at` method
#//     array.values_at(selector, ...)  --> new_array
#// Returns array made from the the values at corresponding indicies
a = %w[ a b c d e f ]

a.values_at(1, 3, 5)            #=> ["b", "d", "f"]
a.values_at(1, 3, 5, 7)         #=> ["b", "d", "f", nil]
a.values_at(-1, -2, -2, -7)     #=> ["f", "e", "e", nil]
a.values_at(4..6, 3..6)         #=> ["e", "f", nil, "d", "e", "f"]

#// `zip` method
#//     array.zip(arg, ...)  --> new_array
#//     array.zip(arg, ...) {|arr| block}  --> new_array
#// Converts arguments to arrays, then merges elements of `array` with 
#// elements from each argument
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]

[1, 2, 3].zip(a, b)             #=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
[1, 2].zip(a, b)                #=> [[1, 4, 7], [2, 5, 8]]
a.zip([1, 2], [8])              #=> [[4, 1, 8], [5, 2, nil], [6, nil, nil]]

#// `|` operator
#//     array | other_array  --> new_array
#// Makes a new array from combining two provided, excluding duplicate 
#// values and preserving order.
[ "a", "b", "c" ] | [ "c", "d", "a" ]  #=> [ "a", "b", "c", "d" ]
