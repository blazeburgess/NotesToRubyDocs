#// # Proc
#//
#// Proc objects are blocks of code bound to local variables. Since it is 
#// bound, the block can be called in various contexts while retaining 
#// access to the object's variables.
def gen_times(factor)
  return Proc.new { |n| n * factor }
end

times3 = gen_times(3)
times5 = gen_times(5)

time3.call(12)                  #=> 36
times5.call(5)                  #=> 25
times3.call(times5.call(4))     #=> 60

#// ## Public Class Methods
#//
#// `new` method
#//     Proc.new {|..| block }  --> a_proc
#//     Proc.new  --> a_proc
#// Creates a proc object bound to the current context. Without a block, 
#// Proc::new can only be called within a method that has an attache block,
#// which is convreted to the proc object
def proc_from
  Proc.new
end

proc = proc_from { "hello" }

proc.call                    #=> "hello"

#// ## Public Instance Methods
#//
#// `arity` method
#//     proc.arity  --> fixnum
#// Returns the number of mandatory arguments proc takes. If the block takes
#// optional arguments it returns -n-1 (negative `n` minus 1). A proc with 
#// no argument declarations is equivlent to a block declaring { || }
proc {}.arity               #=> 0
proc { || }.arity           #=> 0
proc { |a| }.arity          #=> 1
proc { |a, b| }.arity       #=> 2
proc { |a, b, c| }.arity    #=> 3
proc { |*a| }               #=> -1
proc { |a, *b| }.arity      #=> -2
proc { |a, *b, c| }.arity   #=> -3
proc { x:, y:, z: 0}.arity  #=> 1
proc {|*a, x:, y:0|}.arity  #=> -2

proc { |x=0| }.arity        #=> 0
lambda { |x=0| }.arity      #=> -1
proc { |x=0, y| }.arity     #=> 1
lambda { |x=0, y| }.arity   #=> -2
proc { |x=0, y=0| }.arity   #=> 0
lambda {|x=0,y=0|}.arity    #=> -1
proc { |x, y=0| }.arity     #=> 1
lambda {|x, y=0|}.arity     #=> -2
proc {|(x, y), z=0|}.arity  #=> 1
lambda {|(x,y),z=0|}.arity  #=> -2
proc {|a, x:0, z:0|}.arity  #=> 1
lambda {|a,x:0,z:0|}.arity  #=> -2

#// `binding` method
#//     prc.binding  --> binding
#// Returns the binding associated with `prc` can be used as a second param
#// for Kernel#eval (which accepts Procs or bindings)
def fred(param)
  proc {}
end

b = fred(99)
eval("param", b.binding)    #=> 99

#// `curry` method
#//     prc.curry  --> a_proc
#//     prc.curry(arity)  --> a_proc
#// Returns a curried proc. Optional argument for arity, which determines 
#// the number of arguments. If sufficient arguments are passed through it
#// pushes these to the proc and returns the result
b = proc {|x, y, z| (x||0) + (y||0) + (z||0)}

p b.curry[1][2][3]          #=> 6
p b.curry[1, 2][3, 4]       #=> 6
p b.curry[1, 4][3, 4]       #=> 8
p b.curry(5)[1][2][3][4][5] #=> 6
p b.curry(5)[1, 2][3, 4][5] #=> 6
p b.curry(1)[1]             #=> 1

b = proc {|x,y,z,*w| (x||0)+(y||0)+(z||0)+w.inject(0,&:+)}

p b.curry[1][2][3]          #=> 6
p b.curry[1, 2][3, 4]       #=> 10
p b.curry(5)[1][2][3][4][5] #=> 15
p b.curry(5)[1, 2][3, 4][5] #=> 15
p b.curry(1)[1]             #=> 1

b = lambda {|x, y, z| (x||0) + (y||0) + (z||0)}

p b.curry[1][2][3]          #=> 6
p b.curry[1, 2][3, 4]       #=> wrong number of arguments (given 4, exptd 3)
p b.curry(5)                #=> wrong number of arguments (given 5, exptd 3)
p b.curry(1)                #=> wrong number of arguments (given 1, exptd 3)

b = lambda {|x, y, z, *w| (x||0)+(y||0)+(z||0)+ w.inject(0, &:+)}

p b.curry[1][2][3]          #=> 6
p b.curry[1, 2][3, 4]       #=> 10
p b.curry(5)[1][2][3][4][5] #=> 15
p b.curry(5)[1, 2][3, 4][5] #=> 15
p b.curry(1)                #=> wrong number of arguments (given 1, exptd 3)

b = proc { :foo }
p b.curry[]                 #=> :foo

        
       
