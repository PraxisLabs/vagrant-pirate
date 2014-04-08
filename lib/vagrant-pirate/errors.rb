module Pirate
  module Errors

    class PirateError < Vagrant::Errors::VagrantError
      def error_namespace; "vagrant.plugins.pirate.errors"; end
    end

    class VagrantfileExistsError < PirateError
      error_key :vagrantfile_exists
    end

    class EnabledDirMissing < PirateError
      error_key :enabled_dir_missing
    end

  end
end
