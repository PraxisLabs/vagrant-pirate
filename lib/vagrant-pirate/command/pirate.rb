require 'optparse'

module VagrantPlugins
  module VagrantPirate
    module Command
      class Pirate < Vagrant.plugin("2", :command)
        def self.synopsis
          "Manage YAML-based projects."
        end

        def initialize(argv, env)
          super

          @main_args, @sub_command, @sub_args = split_main_and_subcommand(argv)

          @subcommands = Vagrant::Registry.new

          @subcommands.register(:ship) do
            require File.expand_path("../pirate_ship", __FILE__)
            PirateShip
          end

          @subcommands.register(:fleet) do
            require File.expand_path("../pirate_fleet", __FILE__)
            PirateFleet
          end

          @subcommands.register(:update) do
            require File.expand_path("../pirate_update", __FILE__)
            PirateUpdate
          end
        end

        def execute
          if @main_args.include?("-h") || @main_args.include?("--help")
            # Print the help for all the box commands.
            return help
          end

          # If we reached this far then we must have a subcommand. If not,
          # then we also just print the help and exit.
          command_class = @subcommands.get(@sub_command.to_sym) if @sub_command
          return help if !command_class || !@sub_command
          @logger.debug("Invoking command class: #{command_class} #{@sub_args.inspect}")

          # Initialize and execute the command class
          command_class.new(@sub_args, @env).execute
        end

        # Prints the help out for this command
        def help
          opts = OptionParser.new do |opts|
            opts.banner = "Usage: vagrant pirate <command> [<args>]"
            opts.separator ""
            opts.separator "Available subcommands:"

            # Add the available subcommands as separators in order to print them
            # out as well.
            keys = []
            @subcommands.each { |key, value| keys << key.to_s }

            keys.sort.each do |key|
              opts.separator "     #{key}"
            end

            opts.separator ""
            opts.separator "For help on any individual command run `vagrant pirate COMMAND -h`"
          end

          @env.ui.info(opts.help, :prefix => false)
        end
      end
    end
  end
end
