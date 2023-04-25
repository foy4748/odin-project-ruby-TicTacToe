class TicTacToe
  attr_reader :board, :player1, :player2, :switch, :size

  def initialize(s=3)
    @board = Array.new(9,nil)
    @player1 = "X"
    @player2 = "O"
    @switch = true
    @size = s

    puts "\nPlayer 1: X || Player 2: O \n"
    puts "\nNow its #{switch ? player1 : player2}\'s turn"
  end

  # Helper methods

  ## Checking whether all 
  ## of the element in the 
  ## tray is X or O
  def all_same?(tray)
    tray.all?{|elm| elm == 0}
  end

  # Winning Logics

  ## Column Scan
  def column_scan?(idx)
    tray = []
    idx = idx.to_i
    initial = board[idx - 1]

    for i in 1..(size-1)
      if idx + i*size > size*size
        nxt = idx + i*size - size*size
      else
        nxt = idx + i*size
      end
      c = initial <=> (board[nxt-1] || "A")
      tray.push(c)
    end
    all_same?(tray)
  end

  ## Diagonal Scan
  def diagonal_scan?()
    result = []
    # From Left -> Right
    start = 1
    initial = board[start - 1]
    tray1 = []

    for i in 1..(size - 1)
      nxt = start + i*(size + 1)
      c = initial <=> (board[nxt - 1] || "A")
      tray1.push(c)
    end
    result.push(all_same?(tray1))

    # From Right -> Left
    start = size
    initial = board[start - 1]
    tray2 = []

    for i in 1..(size - 1)
      nxt = start + i*(size - 1)
      c = initial <=> (board[nxt - 1] || "A")
      tray2.push(c)
    end
    result.push(all_same?(tray2))

    result.any?{|elm| elm == true}
  end

  # Putting Marks
  def put_mark()
    print_board()

    idx = gets().chomp
    index = idx.to_i - 1

    # Putting marks 
    # based on switch state
    if switch
      if !board[index]
        self.board[index] = player1
        @switch = false
      else
        puts "\n #{idx} is Already occupied \n"
      end
    else
      if !board[index]
        self.board[index] = player2
        @switch = true
      else
        puts "\n #{idx} is Already occupied \n"
      end
    end

    # Scanning through 
    # board for Winning combo
    p column_scan?(idx)
    p diagonal_scan?()

    puts "\nNow its #{switch ? player1 : player2}\'s turn"
    put_mark()
  end

  # Display Methods
  def to_s()
    " Current Game: #{@board}\n Player 1 : #{@player1} \n Player 2 : #{@player2}"
  end

  def print_board()
    b = ""
    puts "\n"
    self.board.each_with_index do |item, index|
      b += "#{item || index + 1}#{(index + 1) % size == 0 ? "\n----------\n" : " | "}"
    end

    puts b
  end

end

game = TicTacToe.new
puts game
game.put_mark
