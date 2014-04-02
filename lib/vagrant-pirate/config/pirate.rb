module VagrantPlugins
  module VagrantPirate
    module Config
      class Pirate < Vagrant.plugin("2", :config)
        attr_accessor :map

        def initialize
          @map = UNSET_VALUE
        end

        def finalize!
          if @map == UNSET_VALUE
            @map = { "local" => "local.d", "enabled" => "vms-enabled" }
          end
        end

        def validate(machine)
          errors = _detected_errors
          @map.each() do |name, conf_dir|
            current_dir = Dir.pwd + '/' + conf_dir
            if !File.directory?(current_dir)
              errors << "Configuration directories must exist: #{current_dir}"
            end
          end

          { "pirate" => errors }
        end

      end
    end
  end
end
