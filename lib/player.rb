class Player
  attr_accessor :token, :type, :engine, :board

  def initialize type, engine: engine
    @token = type == 'human' ? 'X' : 'Y'
    @type = type
    @engine = engine
    @board = engine.board
  end

  # call correct token handler for type
  def place_token
    type == 'human' ? place_human_token : place_robot_token
  end

  # Request and place human's input
  def place_human_token
    position = engine.request_human_move
    puts "Human is playing: #{position}"
    engine.board.positions_with_tokens[position] = token
  end

  # Request and place robot's input
  def place_robot_token
    position = determine_robot_move
    puts "Robot is playing: #{position}"
    engine.board.positions_with_tokens[position] = token
  end

  # Find other player by token
  def opponent
    ObjectSpace.each_object(Player).find { |player| player.token != token }
  end

  private

  def determine_robot_move
    # Check for and return optimal move
    winning_robot_position = winning_position_for 'robot'
    return winning_robot_position unless winning_robot_position.nil?

    # Check for and block optimal opponent move
    winning_human_position = winning_position_for 'human'
    return winning_human_position unless winning_human_position.nil?

    # Fallback with random move
    Board::BOARD_POSITIONS.to_a.shuffle.each do |random_position|
      next unless board.positions_with_tokens[random_position].nil?
      return random_position
    end
  end

  def winning_position_for player_type
    # Grab player by type
    player = ObjectSpace.each_object(Player).find { |player| player.type == player_type }

    # Search remaining winning combos for one with single missing play
    Board::WINNING_COMBOS.map do |winning_combo|
      next if winning_combo.any? { |spot| board.positions_with_tokens[spot] == player.opponent.token }
      remaining_spots = winning_combo.reject { |spot| board.positions_with_tokens[spot] == player.token }
      return remaining_spots.first if remaining_spots.length == 1
    end

    nil
  end

end
