#Implementation
#       Allow an object to alter its behavior when its internal state changes. 
#       The object will appear to change its class.
#       An object-oriented state machine
#       wrapper + polymorphic wrappee + collaboration
#
#       State pattern, which allows objects to behave in different ways depending on internal 
#       state. State is used when you need a class to behave differently, such as performing 
#       slightly different computations, based on some arguments passed through to the class. 
#
#       You should use the State pattern when the behaviour of an object should be influenced 
#       by it's state, and when complex conditions tie object behaviour to it's state. 
#
#Collaborators
#       Context::{}
#       State::{}
#       ConcreteState::{}
#
class MP3PlayerContext
  def initialize(state)
    @state = state
  end

  def play
    @state.press_play(self)
  end

  def set_state(state)
    @state = state
  end

  def get_state
    @state
  end
end

class State
  def press_play(mp3_player_context)

  end
end

class StandbyState < State
  def press_play(mp3_player_context)
    mp3_player_context.set_state( PlayingState.new )
  end
end

class PlayingState < State
  def press_play(mp3_player_context)
    mp3_player_context.set_state( StandbyState.new )
  end
end

class Application
  def run
    player = MP3PlayerContext.new( StandbyState.new )
    puts player.get_state.inspect

    player.play
    puts player.get_state.inspect

    player.play
    puts player.get_state.inspect

    player.play
    puts player.get_state.inspect

  end
end

app = Application.new
app.run
