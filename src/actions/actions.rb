module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)
    # verificar que la siguiente casilla este desocupada
    if position_is_valid?(state, next_position)
      # si es valida movemos la serpiente
      move_snake_to(state, next_position)
    else
      # si no es valida terminamos el juego
      end_game(state)
    end
  end

  private

  def self.calc_next_position(state)
    curr_position = state.snake.positions.first
    case state.next_direction
      when  Model::Direction::UP
        # decrementar la fila
        return new_position = Model::Coord.new(curr_position.row - 1, curr_position.col)
      when  Model::Direction::RIGHT
        # imcrementar la columna
        return new_position = Model::Coord.new(curr_position.row, curr_position.col + 1)
      when  Model::Direction::DOWN
        # incrementar la fila
        return new_position = Model::Coord.new(curr_position.row + 1, curr_position.col)
      when  Model::Direction::LEFT
        # decrementar columna
        return new_position = Model::Coord.new(curr_position.row, curr_position.col - 1)
    end
  end

  def self.position_is_valid?(state, position)
    # Verificar que este en al grilla
    is_invalid =  (position.row > state.grid.rows || position.row <= 0) || (position.col > state.grid.cols || position.col <= 0)
    return false if is_invalid
    # Verificar que no este superponiendo a la serpiente
    return !(state.snake.positions.include? position)
  end

  def self.move_snake_to(state, next_position)
    new_positions = [next_position] + state.snake.positions[0...-1]
    state.snake.positions = new_positions
  end

  def self.end_game(state)
    state.game_finished = true
    return state
  end
end
