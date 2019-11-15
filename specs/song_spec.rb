require('minitest/autorun')
require('minitest/reporters')
require_relative('../song')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestSong < Minitest::Test

  def setup
    @song1 = Song.new("Simply the Best", "Tina Turner")
    @song2 = Song.new("Turn Back Time", "Cher")
    @song3 = Song.new("It's All Coming Back", "Celine Dion")
    @song4 = Song.new("Shake It Off", "Taylor Swift")
    @song5 = Song.new("Can't Feel My Face", "The Weekend")
    @song6 = Song.new("Shape of You", "Ed Sheeran")
  end

  def test_get_song_title
    assert_equal("Turn Back Time", @song2.title)
  end

  def test_get_song_artist
    assert_equal("Cher", @song2.artistd)
  end

end
