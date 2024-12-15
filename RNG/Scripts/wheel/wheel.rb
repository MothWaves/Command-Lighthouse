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
DONE - Add command-line option to disable timer.
ABANDONED - Add functionality for multiline options maybe a special syntax for the files.
DONE - Add command-line option to change timer flavor text.
DONE - Add functionality for outputting more than one option (but never the same option twice)
  Essentially, this would loop for a given number of times and each time it outputs a choice it would remove that choice and print another option.
  The flavor text should not roll in between each option.
DONE - Add functionality that automatically outputs all available options.
=end

require 'optparse'

Options = Struct.new(:timer, :text, :choice_number, :print_all)

class Parser
    def self.parse(options)
        args = Options.new(true, "Spinning the Wheel", 1, false)

        opt_parser = OptionParser.new do |parser|
            parser.banner = "Usage: wheel [options]"

            parser.on("--instant", "-t", "Skips Spinning wheel timer.") do
                args.timer = false
            end

            parser.on("-a", "--print-all", "Chooses every option (in a random order).") do
                args.print_all = true
            end

            parser.on("--text TEXT", "-p", "Changes flavor text of Spinning wheel timer.") do |arg|
                args.text = arg
            end

            parser.on("-n", "--choices COUNT", "Specifies how many unique choices should be chosen.") do |arg|
                if args.print_all
                    puts_error "Can't have -n and -a at the same time."
                    Process.exit!(false)
                end
                count = arg.to_i
                if count <= 0 then
                    puts_error "Choice count too low or invalid."
                    Process.exit!(false)
                end
                args.choice_number = count
            end

            parser.on("-h", "--help", "Prints this help") do
                puts parser
                exit
            end
        end

        opt_parser.parse!(options)
        return args
    end
end

def puts_error text
    puts "wheel-rb [ERR]: " + text
end

# Handles command-line flags
def handle_arg_options
    begin 
      args = Parser.parse ARGV
    rescue OptionParser::InvalidOption => e
        puts_error "#{e}"
        Process.exit!(false)
    rescue OptionParser::MissingArgument
        puts_error "Missing Argument"
        Process.exit!(false)
    end
    return args
end

# Artificial timer with some flavor text.
def spin_timer
    print $args.text
    for _ in 1..3
        sleep 0.7
        print "."
    end
    sleep 1.0
    puts
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
        options << file.readline().strip!
    end
    return options
end

# Randomly chooses an option from array of options.
def randomly_choose_option(options)
    rnd = Random.rand(options.length)
    choice = options[rnd]
    options.delete_at(rnd)
    return choice
end


## Main:
$args = handle_arg_options
# Read File
f = open_file
options = get_options f
f.close()

if $args.timer == true
    spin_timer
end
# Choose from option(s)
choices = Array.new()
if $args.print_all
    until options.empty?
        choices.push (randomly_choose_option options)
    end
else
    for _ in 1..$args.choice_number do
        if options.empty?
            choices.append("No more options to choose from!")
            break
        else
            choices.push (randomly_choose_option options)
        end
    end
end

# Output choice(s)
for i in choices do
    puts i
end
Process.exit!(true)
