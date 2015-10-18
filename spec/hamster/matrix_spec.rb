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

end


