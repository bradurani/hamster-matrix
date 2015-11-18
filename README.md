[![Build Status](https://travis-ci.org/bradurani/hamster-matrix.svg?branch=v0.9.3)](https://travis-ci.org/bradurani/hamster-matrix)

# Hamster Matrix

Hamster Matrix is a gem providing a persietent immutable matrix for functional programming in Ruby. It is an extension for the popular [Hamster](https://github.com/hamstergem/hamster/) gem. It creates a matrix by using nested Hamster [Vectors](http://www.rubydoc.info/github/hamstergem/hamster/master/Hamster/Vector).  

It's great for using as a board in 2D video games where the matrix must be modified as the game state changes while leaving references to the old state unchanged, such as when using a time-travelling debugger. It copies the interface from Ruby's [Matrix](http://ruby-doc.org/stdlib-2.0.0/libdoc/matrix/rdoc/Matrix.html) class as much as possible.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hamster-matrix'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hamster-matrix

## Usage

```ruby
require 'hamster-matrix'
a = Hamster::Matrix[[1,0,0],[0,1,0],[0,0,1]]
b = a.set(2,2,'foo')
puts b
# [[1, 0, 0]
#  [0, 1, 0]
#  [0, 0, "foo"]]

puts a
#[[1, 0, 0]
# [0, 1, 0]
# [0, 0, 1]]
```

Implements the following methods replicating the behavior of Ruby's [Matrix](http://ruby-doc.org/stdlib-2.0.0/libdoc/matrix/rdoc/Matrix.html) class as closely as possible

 *** Class Methods
 - []
 - identity
 - build
 - column_vector
 - columns
 - diagonal
 - I
 - identity
 - row_vector
 - rows
 - scalar
 - unit

 *** Instance Methods
  - ==
  - []
  - collect
  - column
  - column_count
  - column_size
  - column_vectors
  - component
  - element
  - empty?
  - get
  - hash
  - inspect
  - map
  - row
  - row_count
  - row_size
  - row_vectors
  - set
  - square?
  - to_a
  - to_matrix
  - to_s
  - zero?

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bradurani/hamster-matrix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

