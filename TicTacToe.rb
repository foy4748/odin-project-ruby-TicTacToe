class TicTacToe
  attr_reader :board, :player1, :player2, :switch

  def initialize()
    @board = Array.new(9,nil)
    @player1 = "X"
    @player2 = "O"
    @switch = true

    puts "\nPlayer 1: X || Player 2: O \n"
  end

end
