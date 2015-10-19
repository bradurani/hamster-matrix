require "hamster/version"
require 'hamster'
require 'matrix'

module Hamster
  class Matrix
    
    # def self.[](*arrays)
    #   @row_vectors = Hamster::Vector.new(*arrays)
    # end

    def initialize(array = Hamster.vector)
      enumerable_check!(array)
      raise TypeError.new('Enumerable must define map') unless array.responds_to?(:map)
      Hamster.vector(*array.map do |a| 
        width = a.length unless width
        unless(width == a.length)
          raise ExceptionForMatrix::ErrDimensionMismatch.new("row size differs (#{a.length} should be #{width}")
        end
        Hamster.vector(*enumerable_check!(a)) 
      end)
    end

    def ==(other)
      return false unless other.is_a? Hamster::Matrix
      self.row_vectors == other.row_vectors
    end
    alias_method :eql?, :==

    def [](i,j)
      row(i)[j]
    end

    def []=(*args)
      raise "Requires 3 args. Call must take the form m[0,0] = 0" unless args.length == 3
      i = args[0]
      j = args[1]
      value = args[2]
      set(i,j,value)
    end

    def set(i,j,value)
      oldRow = row(i)
      newRow = oldRow.set(j, value)
      puts newRow.class
      row_vectors.set(i, newRow)

    end

    def row(i)
      row_vectors[i]
    end

    def row_vectors
      @row_vectors || Hamster::Vector.new
    end

    private 
    def enumerable_check!(enumerable)
      binding.pry
      unless enumerable.is_a?(Enumerable)
        raise TypeError.new('Matrix rows must be Enumerable')
      end
    end


  end
end
