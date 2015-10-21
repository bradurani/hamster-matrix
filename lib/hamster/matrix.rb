require "hamster/version"
require 'hamster'
require 'matrix'

module Hamster

  def self.matrix(array = Hamster.vector)
    Hamster::Matrix.new(array)
  end

  class Matrix
    
    def self.[](*array)
      Hamster::Matrix.new(array)
    end

    def self.identity(n)
      new(::Matrix.identity(n).row_vectors)
    end

    def self.build(row_count, column_count = row_count, &block)
      matrix = ::Matrix.build(row_count, column_count, &block)
      new(matrix.row_vectors)
    end

    def self.column_vector(array)
      matrix = ::Matrix.column_vector(array)
      new(matrix.row_vectors)
    end

    def self.columns(array)
      matrix = ::Matrix.columns(array)
      new(matrix.row_vectors)
    end

    def self.diagonal(*array)
      matrix = ::Matrix.diagonal(*array)
      new(matrix.row_vectors)
    end

    def self.row_vector(row)
      matrix = ::Matrix.row_vector(row)
      new(matrix.row_vectors)
    end

    def self.rows(row)
      matrix = ::Matrix.rows(row)
      new(matrix.row_vectors)
    end

    def self.scalar(n, value)
      matrix = ::Matrix.scalar(n, value)
      new(matrix.row_vectors)
    end

    class << self
      alias_method :I, :identity
      alias_method :unit, :identity
    end

    def initialize(array = Hamster.vector)
      enumerable_check!(array)
      width = nil
      @row_vectors = Hamster.vector(*array.map do |a| 
        enumerable_check!(a)
        width ||= a.size
        unless(width == a.size)
          raise ExceptionForMatrix::ErrDimensionMismatch.new("row size differs (#{a.size} should be #{width})")
        end
        Hamster.vector(*a) 
      end)
    end

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

    def set(i,j,value)
      if(i >= row_vectors.size)
        raise ExceptionForMatrix::ErrDimensionMismatch.new("I index #{i} outside of array bounds")
      end
      oldRow = row(i)
      if(j >= oldRow.size)
        raise ExceptionForMatrix::ErrDimensionMismatch.new("J index #{j} outside of array bounds")
      end
      newRow = oldRow.set(j, value)
      Hamster::Matrix.new(row_vectors.set(i, newRow))
    end

    def row(i)
      row_vectors[i]
    end

    def column_count
      return 0 if row_vectors.size == 0
      return row_vectors.first.size
    end

    def row_count
      return row_vectors.size
    end

    attr_reader :row_vectors

    private 
    def enumerable_check!(enumerable)
      unless enumerable.is_a?(::Enumerable)
        raise TypeError.new('Matrix rows must be Enumerable')
      end
    end

  end
end
