class Reindeer
  getter distance

  def initialize(@name : String, @speed : Int32, @fly_seconds : Int32, @rest_seconds : Int32)
    @distance = 0
    @flying = true
    @counter = @fly_seconds
  end

  def advance
    @distance += @speed if @flying
    @counter -= 1
    if @counter == 0
      @counter = @flying ? @rest_seconds : @fly_seconds
      @flying = !@flying
    end
  end
end

reindeers = [] of Reindeer

input = File.read("#{__DIR__}/input")
input.each_line do |line|
  if line =~ /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./
    name, speed, fly_seconds, rest_seconds = $1, $2.to_i, $3.to_i, $4.to_i
    reindeers << Reindeer.new(name, speed, fly_seconds, rest_seconds)
  end
end

2503.times { reindeers.each &.advance }

puts reindeers.max_of &.distance
