require 'spec_helper'

describe Hamster::Matrix do
  it 'has a version number' do
    expect(Hamster::Matrix::VERSION).not_to be nil
  end
end

describe Hamster::Matrix do
  
  context '#==' do
    context 'true cases' do
      it 'returns true if it compares to matrices with the same values' do
        matrix1 = Hamster::Matrix.new([[1,1],[1,1]])
        matrix2 = Hamster::Matrix.new([[1,1],[1,1]])
        expect(matrix1 == matrix2).to be true
      end

      it 'returns true if it compares to matrices with varying values' do
        matrix1 = Hamster::Matrix.new([[1,2],[3,4]])
        matrix2 = Hamster::Matrix.new([[1,2],[3,4]])
        expect(matrix1 == matrix2).to be true
      end

      it 'returns true if it compares two zero matrices' do
        matrix1 = Hamster::Matrix.new([])
        matrix2 = Hamster::Matrix.new([])
        expect(matrix1 == matrix2).to be true
      end

      it 'returns true if it compares equal non-sqaure matrices' do
        matrix1 = Hamster::Matrix.new([[1,2,3],[3,4,5]])
        matrix2 = Hamster::Matrix.new([[1,2,3],[3,4,5]])
        expect(matrix1 == matrix2).to be true
      end

      it 'returns true if it compares row matrices' do
        matrix1 = Hamster::Matrix.new([[1,2,3]])
        matrix2 = Hamster::Matrix.new([[1,2,3]])
        expect(matrix1 == matrix2).to be true
      end

      it 'returns true if it compares column matrices' do
        matrix1 = Hamster::Matrix.new([[1],[2],[3]])
        matrix2 = Hamster::Matrix.new([[1],[2],[3]])
        expect(matrix1 == matrix2).to be true
      end

      it 'returns true if it compares matrices of any type' do
        matrix1 = Hamster::Matrix.new([[1],['s'],[:foo]])
        matrix2 = Hamster::Matrix.new([[1],['s'],[:foo]])
        expect(matrix1 == matrix2).to be true
      end
    end
    context 'false cases' do
       it 'returns false if it compares to matrices with the same values' do
        matrix1 = Hamster::Matrix.new([[1,1],[1,1]])
        matrix2 = Hamster::Matrix.new([[1,1],[1,2]])
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares to matrices with varying values' do
        matrix1 = Hamster::Matrix.new([[0,2],[3,4]])
        matrix2 = Hamster::Matrix.new([[1,2],[3,4]])
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares two zero matrices' do
        matrix1 = Hamster::Matrix.new([])
        matrix2 = Hamster::Matrix.new([[0]])
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares equal non-sqaure matrices' do
        matrix1 = Hamster::Matrix.new([[1,2,4],[3,4,5]])
        matrix2 = Hamster::Matrix.new([[1,2,3],[3,4,5]])
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares row matrices' do
        matrix1 = Hamster::Matrix.new([[1,2,4]])
        matrix2 = Hamster::Matrix.new([[1,2,3]])
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares column matrices' do
        matrix1 = Hamster::Matrix.new([[1],[8],[3]])
        matrix2 = Hamster::Matrix.new([[1],[2],[3]])
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares matrices of different types' do
        matrix1 = Hamster::Matrix.new([[1],[:foo],[3]])
        matrix2 = Hamster::Matrix.new([[1],[2],[3]])
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares matrix to nil' do
        matrix1 = Hamster::Matrix.new([[1],[:foo],[3]])
        matrix2 = nil
        expect(matrix1 == matrix2).to be false
      end

      it 'returns false if it compares matrix to nil' do
        matrix1 = Hamster::Matrix.new([[1],[:foo],[3]])
        matrix2 = "bar"
        expect(matrix1 == matrix2).to be false
      end

    end
  end

  context '#new' do
    context 'valid args' do
      it 'creates a matrix given an Array' do
        matrix = Hamster::Matrix.new([[1,2],[3,4]])
        expect(matrix.row_vectors.length).to eql 2
        expect(matrix.row_vectors.is_a?(Hamster::Vector)).to be true
        expect(matrix.row_vectors.first).to eql(Hamster.vector(1,2))
        expect(matrix.row_vectors[1]).to eql(Hamster.vector(3,4))
      end

      it 'create a matrix given Hamster::Vectors' do
        matrix = Hamster::Matrix.new(Hamster.vector(
          Hamster.vector(1,2,3),
          Hamster.vector(1,2,3)
        ))
        expected = Hamster::Matrix.new([[1,2,3],[1,2,3]])
        expect(matrix).to eql(expected)
        expect(matrix.row_vectors.is_a?(Hamster::Vector)).to be true
        expect(matrix.row_vectors.first.is_a?(Hamster::Vector)).to be true
      end

      it 'create a matrix given Hamster::Lists' do
        matrix = Hamster::Matrix.new(Hamster.list(
          Hamster.list(1,2,3),
          Hamster.list(1,2,3)
        ))
        expected = Hamster::Matrix.new([[1,2,3],[1,2,3]])
        expect(matrix).to eql(expected)
        expect(matrix.row_vectors.is_a?(Hamster::Vector)).to be true
        expect(matrix.row_vectors.first.is_a?(Hamster::Vector)).to be true
      end

      it 'create a matrix given row matrix' do
        matrix = Hamster::Matrix.new([[1,2,3]])
        expect(matrix.row_vectors.is_a?(Hamster::Vector)).to be true
        expect(matrix.row_vectors.first).to eql(Hamster.vector(1,2,3))
      end
    end

    context 'invalid args' do
      it 'raises error on type mismathc' do
        matrix = Hamster::Matrix.new([[1,1],[1,1]])
        expected = Hamster::Matrix.new([[1,1],[1,1]])
        expect(matrix).to eql(expected)
        expect(matrix.row_vectors.is_a?(Hamster::Vector)).to be true
        expect(matrix.row_vectors.first.is_a?(Hamster::Vector)).to be true
      end
    end

  end

  context '#row_vectors' do
    it 'creates a matrix' do
      matrix = Hamster::Matrix.new([[1,1],[1,1]])
      expected = Hamster.vector(Hamster.vector(1,1), Hamster.vector(1,1))
      expect(matrix.row_vectors).to eql(expected)
    end
  end

  context '#row' do
    it 'returns row at 0' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expected = Hamster.vector(1,2)
      expect(matrix.row(0)).to eql(expected)
    end

    it 'returns row at 1' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expected = Hamster.vector(3,4)
      expect(matrix.row(1)).to eql(expected)
    end
  end

  context '#[]' do
    it 'returns item at 0,0' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix[0,0]).to eql(1)
    end

    it 'returns item at 0,1' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix[0,1]).to eql(2)
    end

    it 'returns item at 1,0' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix[1,0]).to eql(3)
    end

    it 'returns item at 1,1' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix[1,1]).to eql(4)
    end

  end

  context '#[]=' do
    
    it 'raises error if not passed 3 args' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect { matrix[0] = 0 }.to raise_error("Requires 3 args. Call must take the form m[0,0] = 0")
    end    

  end

  context '#set' do
    # it 'sets item at 0,0 persistently' do
    #   matrix = Hamster::Matrix.new([[1,2],[3,4]])
    #   newMatrix = matrix.set(0,0,:foo)
    #   expect(matrix.row_vectors).to eql(Hamster.vector(Hamster.vector(1,2), 
    #                                                    Hamster.vector(3,4)))
    #   expect(newMatrix.row_vectors).to eql(Hamster.vector(Hamster.vector(:foo ,2), 
    #                                                       Hamster.vector(3,4)))
    # end
  end

end


