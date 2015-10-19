require "hamster/matrix/version"
require 'hamster'

module Hamster
  module Matrix
    class Matrix
      # def self.[](*arrays)
      #   @row_vectors = Hamster::Vector.new(*arrays)
      # end

      def initialize(array)
        @row_vectors = Hamster.vector(*array.map { |a| Hamster.vector(*a) })
      end

      def ==(other)
        return false unless other.is_a? Hamster::Matrix::Matrix
        self.row_vectors == other.row_vectors
      end

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
    end
  end
end
