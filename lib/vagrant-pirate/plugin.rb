require 'vagrant-pirate/pirate'

module VagrantPlugins
  module Pirate
    class Plugin < Vagrant.plugin("2")
      name "Yagrant Pirate"
      description <<-DESC
      This plugin enables Vagrant to use YAML files to configure VMs.
      DESC

      config("pirate") do
        require_relative "config/pirate"
        Config::Pirate
      end

      command("pirate") do
        require_relative "command/pirate"
        Command::Pirate
      end

      command("pirate-ship", primary: false) do
        require_relative "command/ship"
        Command::Ship
      end

      command("pirate-fleet", primary: false) do
        require_relative "command/fleet"
        Command::Fleet
      end

    end
  end
end

