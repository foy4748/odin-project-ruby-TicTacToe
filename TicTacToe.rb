class TicTacToe
  attr_reader :board, :player1, :player2, :switch, :size, :score

  def initialize(s=3)
    @board = Array.new(s*s,nil)
    @player1 = "X"
    @player2 = "O"
    @switch = true
    @size = s

    @score = { :X => 0, :O => 0 }

    puts "\n---- Tutorial ----"
    puts "\nPlayer 1: X || Player 2: O \n"
    puts "Press c or C and Enter to exit"
    puts "Press r or R end Enter to reset the game"
    puts "Type 1 ~ #{size*size} and Enter to mark the space\n"
    puts "\nNow its #{switch ? player1 : player2}\'s turn"
  end

  # Helper methods

  ## Checking Row number 
  ## of a given index
  def row_number(idx)
    indexPlusOne = idx.to_i
    return (indexPlusOne / size) + 1 - ((indexPlusOne % size) == 0 ? 1 : 0)
  end

  ## Checking whether all 
  ## of the element in the 
  ## tray is X or O
  def all_same?(tray)
    tray.all?{|elm| elm == 0}
  end

  ## Resetting the board
  def reset_board(turn = false)
    @board = Array.new(size*size,nil)
    @switch = !turn
    puts "\n---- The game has been reset ----"
    puts "Player 1: X || Player 2: O \n"
    puts "Press c or C and Enter to exit"
    puts "\nNow its #{switch ? player1 : player2}\'s turn"
  end
  #--------------------

  # Winning Logics

  ## Row Scan
  def row_scan?(idx)
    idx = idx.to_i
    current_row = row_number(idx)
    initial = board[idx - 1]
    tray = []
    for i in 1..(size - 1)
      nxt = idx + i
      if row_number(nxt) > current_row
        nxt = nxt - size
      end
      c = initial <=> (board[nxt-1] || "A")
      tray.push(c)
    end

    all_same?(tray)
  end

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

    # Terminating Game peacefully
    if idx == "c" || idx == "C"
      exit(0)
    end

    # Resetting Board
    # for r / R input
    if idx == "r" || idx == "R"
      reset_board()
      put_mark()
    end

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

    # Scan through board
    [
      row_scan?(idx),
      column_scan?(idx),
      diagonal_scan?()

    ].any? do |elm|
      # If any scan comes true
      # then the game ends
      if elm == true
        print_board()
        won = switch ? player2 : player1
        key = won.to_sym
        current_score = score.fetch(key)
        @score.store(key, current_score + 1)
        puts "\n\n\nPlayer #{won} has won "
        print_score()
        reset_board(switch)
        put_mark()
      end
    end

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

  def print_score()
    puts "\n ----- Score ----- \n"
    for key, value in self.score
      puts "#{key} : #{value}"
    end
  end
end

game = TicTacToe.new
game.put_mark
