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

# Artificial timer with some flavor text.
def spin_timer
    print "Spinning the wheel"
    for _ in 1..3
        sleep 0.7
        print "."
    end
    sleep 1.0
    puts;puts
end

# Opens and  returns file given as command-line argument.
def open_file
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
    return f
end

# Returns Array with all of the options from provided file.
def get_options(file)
    options = Array.new()
    while not file.eof?
        options << file.readline()
    end
    return options
end

# Randomly chooses an option from array of options.
def randomly_choose_option(options)
    option = options.sample()
    return option
end


f = open_file
options = get_options f
f.close()
spin_timer
option = randomly_choose_option options

puts option
Process.exit!(true)