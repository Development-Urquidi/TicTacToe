class Board

  attr_accessor :positions_with_tokens

  BOARD_POSITIONS = 1..9
  WINNING_COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  # Create hash of board positions with placements as keys
  def initialize
    @positions_with_tokens = Hash[BOARD_POSITIONS.zip]
  end

  # Print board with cell IDs
  def print_board
    BOARD_POSITIONS.each_slice(3) do |cells|
      print_row cells
    end
  end

  # Print board with token placements
  def display
    positions_with_tokens.each_slice(3) do |row|
      print_row row.map{ |cell_id, token| token || cell_id }
    end
  end

  private

  def print_row row
    puts row.join ' | '
  end
end

