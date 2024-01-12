# frozen_string_literal: true

# require_relative './lib/validate'
require_relative './lib/display_game'

def tictactoe(display, validate)
  option = display.wait_input.to_i
  system('clear')

  case option
  when 1 then tictactoe_case1(display, validate)
  when 2 then tictactoe_case2(display, validate)
  when 3 then exit
  else display.print_error
  end

  which_player_won(display, validate) if game_finished?(validate)
end

def player_move(player, validate, display)
  loop do
    system('clear')
    index_map = print_status(player, display, validate)

    break if make_move_p(player, index_map, validate)

    display.print_error
    display.press_to_continue
  end
end

def make_move_p(player, index, validate)
  return false unless validate.valid_move?(index)

  index = validate.search_index_map(index)
  validate.write_to_board(index[0], index[1], player)
  true
end

def print_status(player, display, validate)
  puts 'Enter the number of the cell you want to mark'
  display.print_players(validate.p1, validate.p2)
  display.print_matrix(validate.board)
  puts ''
  display.print_matrix(validate.board_map)
  print "Player #{player} "
  display.wait_input.to_i
end

def player_winner?(player, validate)
  validate.valid_row_marks?(player) ||
    validate.valid_col_marks?(player) ||
    validate.valid_diag_marks?(player)
end

def tictactoe_case1(display, validate)
  validate.reset_board
  loop do
    player_move(validate.p1, validate, display)
    break if player_winner?(validate.p1, validate)

    break unless validate.valid_spaces?

    player_move(validate.p2, validate, display)
    break if player_winner?(validate.p2, validate)
  end
end

def change_symbol_status(player_num, display)
  puts "Player #{player_num}: "
  display.wait_input
end

def change_symbol(player1, player2, validate)
  return false unless validate.validate_players?(player1, player2)

  validate.p1 = player1
  validate.p2 = player2
  true
end

def tictactoe_case2(display, validate)
  puts 'Enter the symbols for the players'
  loop do
    system('clear')
    player1 = change_symbol_status(1, display)
    player2 = change_symbol_status(2, display)

    break if change_symbol(player1, player2, validate)

    display.print_error
    display.press_to_continue
  end
end

def game_with_winner?(validate)
  player_winner?(validate.p1, validate) ||
    player_winner?(validate.p2, validate)
end

def game_finished?(validate)
  return true if game_with_winner?(validate) || !validate.valid_spaces?

  false
end

def which_player_won(display, validate)
  system('clear')
  display.print_matrix(validate.board)
  if player_winner?(validate.p1, validate)
    puts "Player #{validate.p1} won!"
  elsif player_winner?(validate.p2, validate)
    puts "Player #{validate.p2} won!"
  else
    puts 'No one won'
  end
end

display = DisplayGame.new
validate = Validate.new

loop do
  display.print_main_menu
  option = display.wait_input.to_i
  system('clear')

  case option
  when 1
    loop do
      display.print_game_menu
      tictactoe(display, validate)
      display.press_to_continue
      system('clear')
    end
  when 3 then break
  else display.print_error
  end
end
