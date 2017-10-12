require 'pry'


class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end


  def self.create
    song = self.new
    song.save
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song.save
    song
  end

  def self.create_by_name(name)
    song = self.create
    song.name = name
    song
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if !self.find_by_name(name)
      self.create_by_name(name)
    else
      self.find_by_name(name)
    end
  end

  def self.alphabetical
    songs = self.all.sort_by {|song| song.name.downcase }
  end

  def self.new_from_filename(filename)
    words = filename.split(" - ")
    title = words[1].gsub ".mp3" , "" #replace the .mp3 portion of the string with "" so we have just the title
    artist = words[0] #the artist name is split from words

    track = self.new   #make a new Song without adding to @@all
    track.name = title #using .create_by_name we can create and assign a @name
    track.artist_name = artist #set @artist_name to our artist variable
    track
  end

  def self.create_from_filename(filename)
    words = filename.split(" - ")
    title = words[1].gsub ".mp3" , ""
    artist = words[0]

    track = self.create_by_name(title)   #make a new Song and on instantiation add to @@all
    track.artist_name = artist
    track   #return the value
  end

  def self.destroy_all
    self.all.clear
  end

end
