# frozen_string_literal: true

require_relative './../lib/elements_game'
require_relative './../lib/validate'

# DisplayGame class
# this class will be used to display the game to the user
# and get user input
class DisplayGame
  def print_main_menu
    puts '1. New Game'
    puts '3. Exit'
  end

  def print_game_menu
    puts '1. Play'
    puts '2. Change Symbols'
    puts '3. Exit'
  end

  def wait_input
    print 'Enter your choice: '
    gets.chomp
  end

  def print_error
    puts 'Invalid input, please try again'
    puts ''
  end

  def print_players(player1, player2)
    puts "Player 1: #{player1}, Player 2: #{player2}"
  end

  def press_to_continue
    puts 'Press enter to continue...'
    gets.chomp
  end

  def print_matrix(matrix)
    max_lengths = get_max_length(matrix)

    print_border_row(max_lengths)
    matrix.each do |row|
      row.each_with_index do |item, index|
        printf("| %#{max_lengths[index]}s ", item)
      end
      puts '|'
      print_border_row(max_lengths)
    end
  end

  def get_max_length(matrix)
    matrix.transpose.map do |col|
      col.map { |item| item.to_s.length }.max
    end
  end

  def print_border_row(max_lengths)
    puts "+#{max_lengths.map { |len| '-' * (len + 2) }.join('+')}+"
  end
end
