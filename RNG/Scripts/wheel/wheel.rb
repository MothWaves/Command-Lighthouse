#!/usr/bin/env ruby

# wheel-rb: a random line chooser.
=begin description
This command-line script takes in as input the name of a file and then
randomly chooses one of that file's lines and prints it.

Has a artificial timer to make the result more impactful.

It's based on web apps like wheeldecide which take in options and then
randomly choose one of those options.
=end

=begin todo
DONE - Make it take in a file and choose a random line.
DONE - Add artificial timer
- Add command-line option to disable timer.
- Add functionality for multiline options maybe a special syntax for the files.
=end

def spin_timer
    print "Spinning the wheel"
    for _ in 1..3
        sleep 0.7
        print "."
    end
    sleep 1.0
    puts;puts
end

if (ARGV.length != 1)
  puts "wheel-rb [ERR]: Incorrect number of arguments."
  Process.exit!(false)
end
filename = ARGV[0]

if (not File.file?(filename))
  puts "wheel-rb [ERR]: Given file is not a regular file."
  Process.exit!(false)
end
f = File.new(filename, 'r')
if (f.eof?)
  puts "No options given!"
  Process.exit!(true)
end

options = Array.new()
while not f.eof?
  options << f.readline()
end
f.close()

spin_timer

option = options.sample()

puts option
Process.exit!(true)
