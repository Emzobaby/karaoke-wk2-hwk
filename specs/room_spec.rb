require('minitest/autorun')
require('minitest/reporters')
require_relative('../room')
require_relative('../guest')
require_relative('../song')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestRoom < Minitest::Test

  def setup
    @song1 = Song.new("Simply the Best", "Tina Turner")
    @song2 = Song.new("Turn Back Time", "Cher")
    @song3 = Song.new("It's All Coming Back", "Celine Dion")
    @song4 = Song.new("Shake It Off", "Taylor Swift")
    @song5 = Song.new("Can't Feel My Face", "The Weekend")
    @song6 = Song.new("Shape of You", "Ed Sheeran")
    @song7 = Song.new("My Heart Will Go On", "Celine Dion")

    @songs1 = [@song1, @song2, @song3, @song7]
    @songs2 = [@song4, @song5, @song6]

    @guest1 = Guest.new("Emma", 10.00, @song6)
    @guest2 = Guest.new("Matt", 20.00, @song5)
    @guest3 = Guest.new("Caroline", 15.00, @song2)
    @guest4 = Guest.new("Stephanie", 20.00, @song3)
    @guest5 = Guest.new("William", 20.00, @song3)
    @guest6 = Guest.new("Zack", 20.00, @song3)

    @guests = [@guest1, @guest2, @guest3, @guest4, @guest5]

    @room1 = Room.new("Power Ballads", @songs1, 5.00)
    @room2 = Room.new("Chart Toppers", @songs2, 7.00)
  end

  def test_get_room_name
    assert_equal("Power Ballads", @room1.name)
  end

  def test_count_songs
    assert_equal(3, @room2.songs.count)
  end

  def test_check_if_song_in_room_true
    result = @room1.check_song("Simply the Best")
    assert_equal(true, result)
  end

  def test_check_if_song_in_room_false
    result = @room1.check_song("Shake It Off")
    assert_equal(false, result)
  end

  def test_return_all_song_titles_by_artist
    expected = ["It's All Coming Back", "My Heart Will Go On"]
    result = @room1.search_by_artist("Celine Dion")
    assert_equal(expected, result)
  end

  def test_add_song
    @room1.add_song(@song4)
    assert_equal(5, @room1.songs.count)
  end

  def test_remove_song_by_title
    @room1.remove_song("My Heart Will Go On")
    assert_equal(3, @room1.songs.count)
  end

  def test_add_guest_to_room
    @room1.add_guest(@guest3)
    assert_equal(1, @room1.guests.count)
  end

  def test_remove_guest_from_room_by_name
    @room2.add_guest(@guest1)
    @room2.add_guest(@guest2)
    @room2.add_guest(@guest4)
    @room2.remove_guest("Stephanie")
    assert_equal(2, @room2.guests.count)
  end

  def test_room_can_receive_money
    @room1.receive_money(@room1.entry_fee)
    assert_equal(5, @room1.money_received)
  end

  def test_guest_enters_room
    @room1.guest_enters(@guest2)
    assert_equal(1, @room1.guests.count)
    assert_equal(15.00, @guest2.wallet)
    assert_equal(5, @room1.money_received)
  end

  def test_full_capacity
    @room3 = Room.new("Rock Out", @songs1, 5.00, 0.0, @guests)
    result = @room3.guest_enters(@guest6)
    assert_equal("Not your lucky night.", result)
  end

  def test_guest_can_afford_entry_fee
    @guest7 = Guest.new("Lyle", 3.00, @song3)
    result = @room1.guest_enters(@guest7)
    assert_equal("Not your lucky night.", result)
  end

  def test_find_guest_by_name
    @room3 = Room.new("Rock Out", @songs1, 5.00, 0.0, @guests)
    result = @room3.find_guest("Emma")
    assert_equal(@guest1, result)
  end

  def test_guest_not_in_room
    @room3 = Room.new("Rock Out", @songs1, 5.00, 0.0, @guests)
    result = @room3.find_guest("Zack")
    assert_equal("Guest is not in this room.", result)
  end
end
