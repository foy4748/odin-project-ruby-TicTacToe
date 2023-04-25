class TicTacToe
  attr_reader :board, :player1, :player2, :switch

  def initialize()
    @board = Array.new(9,nil)
    @player1 = "X"
    @player2 = "O"
    @switch = true

    puts "\nPlayer 1: X || Player 2: O \n"
  end

  # Display Methods
  def to_s()
    " Current Game: #{@board}\n Player 1 : #{@player1} \n Player 2 : #{@player2}"
  end

end

game = TicTacToe.new
puts game
