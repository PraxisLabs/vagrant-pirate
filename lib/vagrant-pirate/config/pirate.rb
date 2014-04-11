module VagrantPlugins
  module Pirate
    module Config
      class Pirate < Vagrant.plugin("2", :config)
        attr_accessor :map

        def initialize
          @map = UNSET_VALUE
        end

        def finalize!
          if @map == UNSET_VALUE
            @map = { "local" => "local.d", "enabled" => "enabled.d" }
          end
        end

      end
    end
  end
end
