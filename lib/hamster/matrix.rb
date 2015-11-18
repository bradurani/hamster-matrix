require 'hamster'
require 'matrix'

module Hamster
  class Matrix
    
    # Creates a new Hamster Matrix
    #
    # @example
    #   Hamster::Matrix[[1,0,0],[0,1,0],[0,0,1]]
    #   # => Hamster::Matrix[[1,0,0]
    #   #                    [0,1,0]
    #   #                    [0,0,1]]
    #
    # @return [Hamster::Matrix]
    def self.[](*array)
      Hamster::Matrix.new(array)
    end

    # @return [Hamster::Matrix]
    def self.identity(n)
      return new if n == 0
      new(::Matrix.identity(n).row_vectors)
    end

    # @return [Hamster::Matrix]
    def self.build(row_count, column_count = row_count, &block)
      matrix = ::Matrix.build(row_count, column_count, &block)
      new(matrix.row_vectors)
    end

    # @return [Hamster::Matrix]
    def self.column_vector(array)
      matrix = ::Matrix.column_vector(array)
      new(matrix.row_vectors)
    end

    # @return [Hamster::Matrix]
    def self.columns(array)
      matrix = ::Matrix.columns(array)
      new(matrix.row_vectors)
    end

    # @return [Hamster::Matrix]
    def self.diagonal(*array)
      matrix = ::Matrix.diagonal(*array)
      new(matrix.row_vectors)
    end

    # @return [Hamster::Matrix]
    def self.row_vector(row)
      matrix = ::Matrix.row_vector(row)
      new(matrix.row_vectors)
    end

    # @return [Hamster::Matrix]
    def self.rows(row)
      matrix = ::Matrix.rows(row)
      new(matrix.row_vectors)
    end

    # @return [Hamster::Matrix]
    def self.scalar(n, value)
      matrix = ::Matrix.scalar(n, value)
      new(matrix.row_vectors)
    end

    class << self
      alias_method :I, :identity
      alias_method :unit, :identity
    end

    def initialize(array = Hamster::Vector[])
      enumerable_check!(array)
      width = nil
      @row_vectors = Hamster::Vector[*array.map do |a| 
        enumerable_check!(a)
        width ||= a.size
        unless(width == a.size)
          raise ExceptionForMatrix::ErrDimensionMismatch.new("row size differs (#{a.size} should be #{width})")
        end
        Hamster::Vector[*a] 
      end]
    end

    # @return Boolean
    def ==(other)
      return false unless other.is_a? Hamster::Matrix
      self.row_vectors == other.row_vectors
    end
    alias_method :eql?, :==

    def get(i,j)
      row = row(i)
      return nil unless row
      row[j]
    end
    alias_method :[], :get
    alias_method :component, :get
    alias_method :element, :get


    # Sets the value at a certain given index, leaving
    # existing references unchanged
    #
    # @example
    #   a = Hamster::Matrix[[1,0,0],[0,1,0],[0,0,1]]
    #   b = a.set(2,2,'foo')
    #   puts b
    #   # [[1, 0, 0]
    #   #  [0, 1, 0]
    #   #  [0, 0, "foo"]]
    #   puts a
    #   # [[1, 0, 0]
    #   #  [0, 1, 0]
    #   #  [0, 0, 1]]
    #
    # @return [Hamster::Matrix]
    def set(i,j,value)
      if(i >= row_vectors.size)
        raise ExceptionForMatrix::ErrDimensionMismatch.new("I index #{i} outside of array bounds")
      end
      old_row = row(i)
      if(j >= old_row.size)
        raise ExceptionForMatrix::ErrDimensionMismatch.new("J index #{j} outside of array bounds")
      end
      new_row = old_row.set(j, value)
      Hamster::Matrix.new(row_vectors.set(i, new_row))
    end

    # @return [Hamster::Vector]
    def row(i)
      row_vectors[i]
    end

    # @return [Fixnum]
    def column_count
      return 0 if row_vectors.size == 0
      return row_vectors.first.size
    end
    alias_method :column_size, :column_count

    # @return [Fixnum]
    def row_count
      return row_vectors.size
    end
    alias_method :row_size, :row_count

    def collect(&block)
      raise 'You must pass a block to collect' unless block_given?
      new_rows = row_vectors.map { |row| row.map(&block) }
      return Hamster::Matrix.new(new_rows)
    end
    alias_method :map, :collect

    # @return [Fixnum]
    def column(n)
      row_vectors.map { |row| row[n] }
    end

    # @return [Hamster::Vector]
    def column_vectors
      Hamster::Vector[*(0..row_vectors.size).map { |n| column(n) }]
    end

    # @return [Boolean]
    def empty?
      row_vectors.size == 0
    end

    # @return [Hash]
    def hash
      row_vectors.hash
    end

    # @return [String]
    def inspect
      if empty?
        "#{self.class}.empty"
      else
        "#{self.class}#{row_string(19)}"
      end
    end

    # @return [Boolean]
    def square?
      row_count == column_count
    end

    # @return [Array]
    def to_a
      row_vectors.map { |row| row.to_a }.to_a
    end

    # @return [String]
    def to_s
      row_string(1)
    end

    # @return [::Matrix]
    def to_matrix
      ::Matrix[to_a]
    end

    # @return [Boolean]
    def zero?
      row_vectors.all? do |row| 
        row.all? { |elem| elem.is_a?(Numeric) && elem.zero? }
      end
    end

    # @return [Hamster::Vector]
    attr_reader :row_vectors

    private

    # @private 
    def enumerable_check!(enumerable)
      unless enumerable.is_a?(::Enumerable)
        raise TypeError.new('Matrix rows must be Enumerable')
      end
    end

    # @private
    def row_string(spaces)
      br = ''
      row_vectors.inject('[') do |acc, row|
        l = "#{acc}#{br}#{row.to_a.to_s}"
        br = "\n#{' ' * spaces}"
        l
      end + ']'
    end

  end
end
