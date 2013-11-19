class EightQueens
  
  attr_accessor :board
  
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @iterations = 0
    put_queen(0)
    puts @iterations
  end
  
  def put_queen(row)
    @board[row].length.times do |i|
      @iterations += 1
      if is_valid?([row, i])
        @board[row][i] = "Q"
      
        if row < 7
          put_queen(row+1)
        else
          display_solution
        end
        
        @board[row][i] = nil
      end
    end
  end
  
  def is_valid?(pos)
    diag_valid?(pos) && vert_valid?(pos)
  end
  
  def diag_valid?(pos)
    deltas = [[-1, -1], [-1,1]]
    
    deltas.each do |(x, y)|
      curr_pos = [pos[0]+x, pos[1]+y]
      
      until out_of_bounds?(curr_pos)
        return false unless self[curr_pos].nil?

        curr_pos = [curr_pos[0]+x, curr_pos[1]+y]
      end
    end
    
    return true
  end
  
  def vert_valid?(pos)
    curr_pos = [pos[0]-1, pos[1]]
    
    until out_of_bounds?(curr_pos)
      return false unless self[curr_pos].nil?
      
      curr_pos = [curr_pos[0]-1, curr_pos[1]]
    end
    
    return true
  end
   
  def [](pos)
    row, col = pos
    @board[row][col]
  end
  
  def out_of_bounds?(pos)
    pos[0] < 0 || pos[1] < 0 || pos[0] > 7 || pos[1] > 7
  end
  
  def display_solution
    flat_board = @board.flatten
    queen_positions = []
    
    8.times do
      index = flat_board.index("Q")
      flat_board[index] = nil
      
      queen_positions << [index/8, index%8]
    end
    
    puts queen_positions.map { |pos| pos.to_s }.join(", ")
  end
end