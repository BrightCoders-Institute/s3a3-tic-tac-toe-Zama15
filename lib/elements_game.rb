# frozen_string_literal: true

# TicTacToe class
# were going to use this class to store the board and methods to manipulate it
# we will also use this class to store the board_map
# the board_map will be used to display the board to the user
class ElementsGame
  attr_reader :board, :board_map, :reserved_symbol
  attr_accessor :p1, :p2

  def initialize(inputs = {})
    @reserved_symbol = '-'
    @p1 = inputs[:p1].nil? ? 'X' : inputs[:p1]
    @p2 = inputs[:p2].nil? ? 'O' : inputs[:p2]
    @board_map = board_map_init
    @board = Array.new(3) { Array.new(3, @reserved_symbol) }
  end

  def board_map_init
    temp_board = Array.new(3) { Array.new(3) }
    count = 1

    temp_board.each_with_index do |row, i|
      row.each_with_index do |_, j|
        temp_board[i][j] = count
        count += 1
      end
    end

    temp_board
  end

  def search_index_map(value)
    row = (value - 1) / 3
    col = (value - 1) % 3

    [row, col]
  end

  def write_to_board(row, col, value)
    @board[row][col] = value
  end

  def reset_board
    @board = Array.new(3) { Array.new(3, @reserved_symbol) }
  end
end
