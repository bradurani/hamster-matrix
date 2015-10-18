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

      def row_vectors
        @row_vectors || Hamster::Vector.new
      end
    end
  end
end
