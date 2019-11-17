class Room

  attr_reader :name, :songs, :entry_fee, :money_received, :guests, :capacity

  def initialize(name, songs, entry_fee, money_received = 0.0, guests = [], capacity = 5)
    @name = name
    @songs = songs
    @entry_fee = entry_fee
    @money_received = money_received
    @guests = guests
    @capacity = capacity
    @food = Hash.new(0)
    @drinks = Hash.new(0)
  end

  def check_song(song_title)
    return @songs.any? { |song| song.title == song_title }
  end

  def search_by_artist(artist)
    chosen_songs = @songs.find_all { |song| song.artist == artist}
    return chosen_songs.map { |song| song.title }
  end

  def add_song(song)
    @songs << song
  end

  def remove_song(title)
    for song in @songs
      if song.title == title
        @songs.delete(song)
      end
    end
  end

  def add_guest(guest)
    @guests << guest
  end


  def remove_guest(name)
    for guest in @guests
      if guest.name == name
        @guests.delete(guest)
      end
    end
  end

  def receive_money(amount)
    @money_received += amount
  end

  def guest_enters(guest)
    if @guests.count < @capacity && guest.wallet > @entry_fee
      add_guest(guest)
      guest.pay_money(@entry_fee)
      receive_money(@entry_fee)
    end
    return "Not your lucky night."
  end

  def find_guest(guest_name)
    for guest in @guests
      if guest.name == guest_name
        return guest
      end
    end
    return "Guest is not in this room."
  end

  def minus_money(amount)
    @money_received -= amount
  end

  def stock_level_drinks(drink)
    return @drinks[drink]
  end

  def add_drink(drink)
    if @drinks.include?(drink)
      @drinks[drink] += 1
    else
      @drinks[drink] = 1
    end
  end

  def stock_level_food(food)
    return @food[food]
  end

  def add_food(food)
    if @food.include?(food)
      @food[food] += 1
    else
      @food[food] = 1
    end 
  end

end
