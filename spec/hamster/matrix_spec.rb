require 'spec_helper'

describe Hamster do
  describe '#matrix' do
    it 'calls constructor' do
      expect(Hamster.matrix([[1,2,3],[1,2,3]])).to eql Hamster::Matrix.new([[1,2,3],[1,2,3]])
    end

    it 'creates empty matrix' do
      expect(Hamster.matrix).to eql Hamster::Matrix.new
    end
  end
end

describe Hamster::Matrix do
  it 'has a version number' do
    expect(Hamster::Matrix::VERSION).not_to be nil
  end

  describe '#new' do
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
        expect(matrix.row_vectors.all?{ |r| r.is_a?(Hamster::Vector)}).to be true
      end

      it 'create a matrix given Hamster::Lists' do
        matrix = Hamster::Matrix.new(Hamster.list(
          Hamster.list(1,2,3),
          Hamster.list(1,2,3)
        ))
        expected = Hamster::Matrix.new([[1,2,3],[1,2,3]])
        expect(matrix).to eql(expected)
        expect(matrix.row_vectors.is_a?(Hamster::Vector)).to be true
        expect(matrix.row_vectors.all?{ |r| r.is_a?(Hamster::Vector)}).to be true
      end

      it 'create a matrix given row matrix' do
        matrix = Hamster::Matrix.new([[1,2,3]])
        expect(matrix.row_vectors.is_a?(Hamster::Vector)).to be true
        expect(matrix.row_vectors.first).to eql(Hamster.vector(1,2,3))
      end

      it 'create a matrix given nothing' do
        matrix = Hamster::Matrix.new
        expect(matrix.row_vectors).to eql(Hamster.vector)
      end

      it 'create a matrix given empty array' do
        matrix = Hamster::Matrix.new([])
        expect(matrix.row_vectors).to eql(Hamster.vector)
      end
    end

    context 'invalid args' do
      it 'raises a ExceptionForMatrix::ErrDimensionMismatch with mismatched dims' do
        expect { Hamster::Matrix.new([[1,2],[1,2,3]]) }.to raise_error(ExceptionForMatrix::ErrDimensionMismatch, "row size differs (3 should be 2)")
      end

      it 'raises a ExceptionForMatrix::ErrDimensionMismatch with mismatched dims and types' do
        expect { Hamster::Matrix.new([[1,2, :foo],['s','f']]) }.to raise_error(ExceptionForMatrix::ErrDimensionMismatch, "row size differs (2 should be 3)")
      end

      it 'raises a type error for non-enumerables' do
        expect { Hamster::Matrix.new([[1,2],1]) }.to raise_error(TypeError)
      end

      it 'raises a type error given flat array' do
        expect { Hamster::Matrix.new([1,2,3]) }.to raise_error(TypeError)
      end

      it 'raises a type error given flat array' do
        expect { Hamster::Matrix.new([1,2,3]) }.to raise_error(TypeError)
      end
    end
  end

  describe '#identity' do
    it 'creates an identity matrix' do
      expect(Hamster::Matrix.identity(3)).to eql(Hamster::Matrix.new([[1,0,0],[0,1,0],[0,0,1]]))
    end

    it 'creates an empty matrix' do
      expect(Hamster::Matrix.identity(0)).to eql(Hamster::Matrix.new)
    end
  end

  describe '#I' do
    it 'creates an identity matrix' do
      expect(Hamster::Matrix.identity(3)).to eql(Hamster::Matrix.new([[1,0,0],[0,1,0],[0,0,1]]))
    end
  end

  describe '#build' do
    it 'builds given a block' do
      matrix = Hamster::Matrix.build(2,2) do |i,j|
        i * j
      end
      expect(matrix).to eql(Hamster::Matrix.new([[0,0],[0,1]]))
    end
  end

  describe '#column_vector' do
    it 'builds column matrix' do
      matrix = Hamster::Matrix.column_vector([1,2,3])
      expect(matrix).to eql(Hamster::Matrix.new([[1],[2],[3]]))
    end

    it 'builds column matrix from a Hamster::List' do
      matrix = Hamster::Matrix.column_vector(Hamster::List[1,2,3])
      expect(matrix).to eql(Hamster::Matrix.new([[1],[2],[3]]))
    end
  end

  describe '#columns' do
    it 'builds matrix from columns' do
      matrix = Hamster::Matrix.columns([[1,2,3],[4,5,6]])
      expect(matrix).to eql(Hamster::Matrix.new([[1,4],[2,5],[3,6]]))
    end
  end

  describe '#diagonal' do
    it 'builds matrix from diagonal' do
      matrix = Hamster::Matrix.diagonal(1,2,3)
      expect(matrix).to eql(Hamster::Matrix.new([[1,0,0],[0,2,0],[0,0,3]]))
    end
  end

  describe '#row_vector' do
    it 'builds a row matrix' do
      matrix = Hamster::Matrix.row_vector([1,2,3])
      expect(matrix).to eql(Hamster::Matrix.new([[1,2,3]]))
    end
  end

  describe '#rows' do
    it 'builds matrix' do
      matrix = Hamster::Matrix.rows([[1,2,3],[4,5,6]])
      expect(matrix).to eql(Hamster::Matrix.new([[1,2,3],[4,5,6]]))
    end
  end

  describe '#scalar' do
    it 'builds scalar matrix' do
      matrix = Hamster::Matrix.scalar(2,5)
      expect(matrix).to eql(Hamster::Matrix.new([[5,0],[0,5]]))
    end
  end

  describe '#unit' do
    it 'creates an identity matrix' do
      expect(Hamster::Matrix.identity(3)).to eql(Hamster::Matrix.new([[1,0,0],[0,1,0],[0,0,1]]))
    end
  end

end

describe Hamster::Matrix do
  
  describe '#[]' do
    it 'calls constructor' do
      expect(Hamster::Matrix[[1,2,3],[1,2,3]]).to eql Hamster::Matrix.new([[1,2,3],[1,2,3]])
    end

    it 'creates empty matrix' do
      expect(Hamster::Matrix[]).to eql Hamster::Matrix.new
    end
  end

  describe '#==' do
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

  describe '#row_vectors' do
    it 'creates a matrix' do
      matrix = Hamster::Matrix.new([[1,1],[1,1]])
      expected = Hamster.vector(Hamster.vector(1,1), Hamster.vector(1,1))
      expect(matrix.row_vectors).to eql(expected)
    end
  end

  describe '#row' do
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

  describe '#get' do
    it 'returns item at 0,0' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix.get(0,0)).to eql(1)
    end

    it 'returns item at 0,1' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix.get(0,1)).to eql(2)
    end

    it 'returns item at 1,0' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix.get(1,0)).to eql(3)
    end

    it 'returns item at 1,1' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix.get(1,1)).to eql(4)
    end

    it 'returns nil if I out-of-bounds' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix.get(10,1)).to eql(nil)
    end

    it 'returns nil if J out-of-bounds' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix.get(1,10)).to eql(nil)
    end

  end
  
  describe '#[]' do
    it 'calls #get' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix[0,0]).to eql(1)
    end
  end

  describe '#set' do
    it 'sets item at 0,0 persistently' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      newMatrix = matrix.set(0,0,:foo)
      expect(matrix).to eql(Hamster::Matrix.new([[1,2],[3,4]]))
      expect(newMatrix).to eql(Hamster::Matrix.new([[:foo,2],[3,4]]))
    end

    it 'sets item at 0,1 persistently' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      newMatrix = matrix.set(0,1,"foo")
      expect(matrix).to eql(Hamster::Matrix.new([[1,2],[3,4]]))
      expect(newMatrix).to eql(Hamster::Matrix.new([[1,"foo"],[3,4]]))
    end

    it 'raise ExceptionForMatrix::ErrDimensionMismatch if I out-of-bounds' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect { matrix.set(10,0,"foo") }.to raise_error(ExceptionForMatrix::ErrDimensionMismatch, 'I index 10 outside of array bounds')
    end

    it 'raise ExceptionForMatrix::ErrDimensionMismatch if J out-of-bounds' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect { matrix.set(0,20,"foo") }.to raise_error(ExceptionForMatrix::ErrDimensionMismatch, 'J index 20 outside of array bounds')
    end

  end

  describe '#column_count' do
    it 'gets column count' do
      matrix = Hamster::Matrix.new([[1,2,3],['a','b','c']])
      expect(matrix.column_count).to eql(3)
    end

    it 'gets column count for row matrix' do
      matrix = Hamster::Matrix.new([[1,2,3]])
      expect(matrix.column_count).to eql(3)
    end

    it 'gets column count for empty matrix' do
      matrix = Hamster::Matrix.new
      expect(matrix.column_count).to eql(0)
    end
  end

  describe '#row_count' do
    it 'gets row count' do
      matrix = Hamster::Matrix.new([[1,2,3],['a','b','c']])
      expect(matrix.row_count).to eql(2)
    end

    it 'gets row count for row matrix' do
      matrix = Hamster::Matrix.new([[1,2,3]])
      expect(matrix.row_count).to eql(1)
    end

    it 'gets column count for column matrix' do
      matrix = Hamster::Matrix.new([[1],[2],[3]])
      expect(matrix.row_count).to eql(3)
    end

    it 'gets column count for empty matrix' do
      matrix = Hamster::Matrix.new
      expect(matrix.row_count).to eql(0)
    end
  end

  describe '#collect' do
    it 'transforms all elements in the matrix' do
      matrix = Hamster::Matrix.new([[1,2,3],[4,5,6]])
      expect(matrix.collect{ |i| i * 2 }).to eql(Hamster::Matrix.new([[2,4,6],[8,10,12]]))
    end

    it 'raised error if not given block' do
      matrix = Hamster::Matrix.new([[1,2,3],[4,5,6]])
      expect { matrix.collect }.to raise_error
    end
  end

  describe '#column' do
    it 'returns the middle column' do
      matrix = Hamster::Matrix.new([[1,2,3],[4,5,6]])
      expect(matrix.column(1)).to eql(Hamster.vector(2,5))
    end
  end

  describe '#column_vectors' do
    it 'returns all columns' do
      matrix = Hamster::Matrix.new([[1,2,3],[4,5,6]])
      expect(matrix.column_vectors).to eql(Hamster::Matrix.new([[1,4],[2,5],[3,6]]).row_vectors)
    end
  end

  describe '#empty?' do
    it 'return true for empty' do
      matrix = Hamster::Matrix.new
      expect(matrix.empty?).to eql(true)
    end

    it 'return false if not empty' do
      matrix = Hamster::Matrix.new([[1,2],[3,4]])
      expect(matrix.empty?).to eql(false)
    end
  end

  describe '#hash' do
    it 'returns a hash' do
      matrix = Hamster::Matrix.new([[2,8],[4,5]])
      expect(matrix.hash).to be_a(Bignum)
    end
  end

  describe '#inspect' do
    it 'returns empty for empty' do
      matrix = Hamster::Matrix.new
      expect(matrix.inspect).to eql('Hamster::Matrix.empty')
    end

    it 'returns string for matrix' do
      matrix = Hamster::Matrix.new([[8,8,8],[3,4,5]])
      expected =
<<-FOO
Hamster::Matrix[[8, 8, 8]
                [3, 4, 5]]
FOO
      expect(matrix.inspect).to eql(expected.strip)
    end
  end

  describe '#square?' do
    it 'returns true if square' do
      matrix = Hamster::Matrix.new([[2,8],[4,5]])
      expect(matrix.square?).to be(true)
    end

    it 'returns false if not square' do
      matrix = Hamster::Matrix.new([[2,8,1],[4,5,6]])
      expect(matrix.square?).to be(false)
    end

    it 'returns true for empty' do
      matrix = Hamster::Matrix.new
      expect(matrix.square?).to be(true)
    end
  end

  describe '#to_a' do
    it 'returns nested arrays' do
      matrix = Hamster::Matrix.new([[2,8],[4,5]])
      expect(matrix.to_a).to eql([[2,8],[4,5]])
    end
  end

  describe '#to_s' do
    it 'returns pretty string' do
      matrix = Hamster::Matrix.new([[3,3,4],[6,5,4]])
      expected = 
<<-FOO
[[3, 3, 4]
 [6, 5, 4]]
FOO
      expect(matrix.to_s).to eql(expected.strip!)
    end
  end

  describe '#zero?' do
    it 'returns true for zeros' do
      matrix = Hamster::Matrix.new([[0,0],[0,0]])
      expect(matrix.zero?).to eql(true)
    end

    it 'returns false for not zeros' do
      matrix = Hamster::Matrix.new([[1,0],[0,0]])
      expect(matrix.zero?).to eql(false)
    end

    it 'returns false for non-numeric' do
      matrix = Hamster::Matrix.new([[0,'s'],[0,0]])
      expect(matrix.zero?).to eql(false)
    end

    it 'returns true for empty' do
      matrix = Hamster::Matrix.new
      expect(matrix.zero?).to eql(true)
    end    
  end

end


