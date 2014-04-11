module Pirate
  module Errors

    class PirateError < Vagrant::Errors::VagrantError
      def error_namespace; "vagrant.plugins.pirate.errors"; end
    end

    class VagrantfileExistsError < PirateError
      error_key :vagrantfile_exists
    end

    class PiratefileExistsError < PirateError
      error_key :piratefile_exists
    end

    class ConfigDirExistsError < PirateError
      error_key :config_dir_exists
    end

    class ConfigDirMissingError < PirateError
      error_key :config_dir_missing
    end

    class LocalFileExistsError < PirateError
      error_key :local_file_exists
    end

    class SymlinkExistsError < PirateError
      error_key :symlink_exists
    end



  end
end
