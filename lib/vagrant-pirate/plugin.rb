require 'vagrant-pirate/vagrant-pirate'

module VagrantPlugins
  module VagrantPirate
    class Plugin < Vagrant.plugin("2")
      name "Yagrant YAML"
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
        require_relative "command/pirate_ship"
        Command::PirateShip
      end

      command("pirate-update", primary: false) do
        require_relative "command/pirate_update"
        Command::PirateUpdate
      end
    end
  end
end

