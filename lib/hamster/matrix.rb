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

    def initialize(array = Hamster.vector)
      enumerable_check!(array)
      width = nil
      @row_vectors = Hamster.vector(*array.map do |a| 
        enumerable_check!(a)
        width ||= a.length
        unless(width == a.length)
          raise ExceptionForMatrix::ErrDimensionMismatch.new("row size differs (#{a.length} should be #{width})")
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
      if(i >= row_vectors.length)
        raise ExceptionForMatrix::ErrDimensionMismatch.new("I index #{i} outside of array bounds")
      end
      oldRow = row(i)
      if(j >= oldRow.length)
        raise ExceptionForMatrix::ErrDimensionMismatch.new("J index #{j} outside of array bounds")
      end
      newRow = oldRow.set(j, value)
      Hamster::Matrix.new(row_vectors.set(i, newRow))
    end

    def row(i)
      row_vectors[i]
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
