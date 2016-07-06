class Engine
  attr_accessor :board, :current_player
  include Helpers

  def start
    # Create playing field
    self.board = Board.new

    # Create players
    human = Player.new 'human', engine: self
    robot = Player.new 'robot', engine: self

    # Determine turn order
    ask 'Do you want to go first?'
    affirmed = check_affirmation_of answer
    self.current_player = affirmed ? human : robot

    # Print board
    board.print_board

    # Play through each turn
    available_moves = Board::BOARD_POSITIONS
    available_moves.each { current_player.place_token and check_for_winner }
  end

  def request_human_move
    # Determine token placement
    ask 'Where do you want to play?'
    position = answer.to_i

    # Validate and return placement
    if !Board::BOARD_POSITIONS.include? position
      replay 'Invalid input, try a number between 1 to 9'
    elsif board.positions_with_tokens[position]
      replay 'Position already occupied, try another spot instead'
    else
      position
    end
  end

  private

  def check_for_winner
    board.display

    # Check if a winning combo is complete
    Board::WINNING_COMBOS.each do |winning_combo|
      if winning_combo.all? { |spot| board.positions_with_tokens[spot] == current_player.token }
        puts "The #{current_player.type} wins!"
        exit
      end
    end

    # End game if all spots used
    if board.positions_with_tokens.values.none? &:nil?
      puts 'Game is a draw'
      exit
    end

    # Move to opponent's turn
    self.current_player = current_player.opponent
  end

  # Print error and replay human move
  def replay message
    puts message
    request_human_move
  end

end
