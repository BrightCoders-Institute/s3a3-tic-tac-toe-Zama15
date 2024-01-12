# frozen_string_literal: true

require_relative 'elements_game'

# Validate class
# this class will be used to validate the user input, and
# rules of the game
class Validate < ElementsGame
  def initialize(inputs = {})
    super(inputs)
  end

  def validate_players?(player1, player2)
    player1 != reserved_symbol && player2 != reserved_symbol && player1 != player2
  end

  def valid_move?(index_map)
    return false unless index_map.between?(1, 9)

    index = search_index_map(index_map)

    board[index[0]][index[1]] == reserved_symbol
  end

  def valid_input?(input)
    input == p1 || input == p2
  end

  def valid_row_marks?(player)
    board.each do |row|
      return true if row.all? { |mark| mark == player }
    end

    false
  end

  def valid_col_marks?(player)
    board.transpose.each do |col|
      return true if col.all? { |mark| mark == player }
    end

    false
  end

  def valid_diag_marks?(player)
    diagonals_from_board.each do |diag|
      validate = true
      diag.each do |index|
        validate = false unless board[index[0]][index[1]] == player
      end
      return true if validate
    end

    false
  end

  def diagonals_from_board
    diagonals_map = [[1, 5, 9], [3, 5, 7]]
    diagonals = []

    diagonals_map.each do |diag|
      diagonals << diag.map { |index| search_index_map(index) }
    end

    diagonals
  end

  def valid_spaces?
    board.flatten.any?('-')
  end
end
