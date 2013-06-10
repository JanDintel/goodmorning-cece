require 'audite'

@player = Audite.new

@player.events.on(:complete) do
  puts "FINISHED SAMPLE"
end

def run(input)
  input.downcase!
  words = input.split(' ')
  words.each { |word| @player.load("audio/cece/#{word}.mp3"); @player.start_stream }
end

repl = -> prompt { print prompt; run(gets.chomp) }
number = 1
loop { repl["[#{number}] cece> "]; number+=1 }

