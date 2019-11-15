require('minitest/autorun')
require('minitest/reporters')
require_relative('../guest')
require_relative('../song')
require_relative('../room')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestGuest < Minitest::Test

  def setup
    @song1 = Song.new("Simply the Best", "Tina Turner")
    @song2 = Song.new("Turn Back Time", "Cher")
    @song3 = Song.new("It's All Coming Back", "Celine Dion")
    @song4 = Song.new("Shake It Off", "Taylor Swift")
    @song5 = Song.new("Can't Feel My Face", "The Weekend")
    @song6 = Song.new("Shape of You", "Ed Sheeran")

    @songs1 = [@song1, @song2, @song3, @song7]
    @songs2 = [@song4, @song5, @song6]

    @guest1 = Guest.new("Emma", 10.00, @song6)
    @guest2 = Guest.new("Matt", 20.00, @song5)
    @guest3 = Guest.new("Caroline", 15.00, @song2)
    @guest4 = Guest.new("Stephanie", 20.00, @song3)

    @room1 = Room.new("Power Ballads", @songs1, 5.00)
    @room2 = Room.new("Chart Toppers", @songs2, 7.00)
  end

  def test_get_guest_name
    assert_equal("Stephanie", @guest4.name)
  end

  def test_get_guest_money
    assert_equal(20.00, @guest2.wallet)
  end

  def test_get_fave_song
    assert_equal(@song2, @guest3.fave_song)
  end

  def test_get_fave_song_title
    assert_equal("Shape of You", @guest1.fave_song.title)
  end

  def test_can_change_fave_song
    @guest2.change_fave_song(@song4)
    assert_equal("Shake It Off", @guest2.fave_song.title)
  end

  def test_pay_money
    @guest1.pay_money(@room1.entry_fee)
    assert_equal(5.00, @guest1.wallet)
  end

  def test_favourite_song
    result = @guest1.favourite_song(@room2)
    assert_equal("Wooooo!", result)
  end

  def test_current_room
    @guest1.enter_room(@room2)
    result = @guest1.favourite_song(@room2)
    assert_equal(@room2, @guest1.current_room)
    assert_equal("Wooooo!", result)
  end


end
