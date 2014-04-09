module Pirate
  module Errors

    class PirateError < Vagrant::Errors::VagrantError
      def error_namespace; "vagrant.plugins.pirate.errors"; end
    end

    class VagrantfileExistsError < PirateError
      error_key :vagrantfile_exists
    end

    class ConfigDirMissing < PirateError
      error_key :config_dir_missing
    end

  end
end
