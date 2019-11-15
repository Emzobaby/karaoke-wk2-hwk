class Guest

  attr_reader :name, :wallet, :fave_song, :current_room

  def initialize(name, wallet, fave_song, current_room = 0)
    @name = name
    @wallet = wallet
    @fave_song = fave_song
    @current_room = current_room
  end

  def change_fave_song(song)
    @fave_song = song
  end

  def pay_money(amount)
    @wallet -= amount
  end

  def favourite_song(room)
    for song in room.songs
      if song == @fave_song
        return "Wooooo!"
      end
    end
  end

  def enter_room(room)
    @current_room = room
    favourite_song(room)
  end

end
