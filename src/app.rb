require_relative "view/ruby2d"
require_relative "model/state"
require_relative "actions/actions"

class App

  def initialize
    @state = Model::initial_state
  end

  def start
    # puts "Hola!!!"
    @view = View::Ruby2dView.new(self)
    timer_thread = Thread.new {init_timer(@view)}
    @view.start(@state)
    timer_thread.join
  end

  def init_timer(view)
    loop do
      if @state.game_finished
        puts "Juego Finalizado"
        puts "Puntaje: #{@state.snake.positions.length}"
        break
      end
      @state = Actions::move_snake(@state)
      view.render(@state)
      sleep 0.5
      # trigger movement
    end
  end

  def send_action(action, param)
    new_state = Actions.send(action, @state, param)
    if new_state.hash != @state
      @state = new_state
      @view.render(@state)
    end
  end
end

app = App.new
app.start
