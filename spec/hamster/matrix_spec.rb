require 'spec_helper'

describe Hamster::Matrix do
  it 'has a version number' do
    expect(Hamster::Matrix::VERSION).not_to be nil
  end
end

describe Hamster::Matrix::Matrix do
  
  context '#new' do
    it 'creates a matrix' do
      matrix = Hamster::Matrix::Matrix.new([[1,1],[1,1]])
      expected = Hamster.vector(Hamster.vector(1,1), Hamster.vector(1,1))
      expect(matrix.row_vectors).to eql(expected)
    end
  end

  context '#row_vectors' do
    it 'creates a matrix' do
      matrix = Hamster::Matrix::Matrix.new([[1,1],[1,1]])
      expected = Hamster.vector(Hamster.vector(1,1), Hamster.vector(1,1))
      expect(matrix.row_vectors).to eql(expected)
    end
  end

  context '#row' do
    it 'returns row at 0' do
      matrix = Hamster::Matrix::Matrix.new([[1,2],[3,4]])
      expected = Hamster.vector(1,2)
      expect(matrix.row(0)).to eql(expected)
    end

    it 'returns row at 1' do
      matrix = Hamster::Matrix::Matrix.new([[1,2],[3,4]])
      expected = Hamster.vector(3,4)
      expect(matrix.row(1)).to eql(expected)
    end
  end

end


