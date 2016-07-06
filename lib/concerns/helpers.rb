module Helpers
  AFFIRMATIVE_RESPONSES = %w{y yes yep yeah sure ok}

  alias answer gets

  # Checks if response is truthy
  def check_affirmation_of message
    AFFIRMATIVE_RESPONSES.include? message.chomp.downcase
  end

  # Aliases #print, adds spacing
  def ask query
    print query.concat "\s"
  end
end