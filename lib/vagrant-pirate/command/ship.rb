require 'optparse'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module Pirate
    module Command
      class Ship < Vagrant.plugin("2", :command)

        def self.synopsis
          "Initializes a new Vagrant environment by creating a Vagrantfile and YAML config files."
        end
        def execute
          options = {}
          opts = OptionParser.new do |opts|
            opts.banner = "Usage: vagrant pirate ship [box-name] [box-url]"
          end

          # Parse the options
          argv = parse_options(opts)
          return if !argv

          create_vagrantfile
          create_piratefile(argv[0], argv[1])
          create_vm_yaml('vm1')

          @env.ui.info(I18n.t("vagrant.plugins.pirate.commands.ship.success"), :prefix => false)

          # Success, exit status 0
          0
        end

        def create_vagrantfile
          save_path = @env.cwd.join("Vagrantfile")
          if save_path.exist?
            raise ::Pirate::Errors::VagrantfileExistsError, :command => 'ship'
          end

          template_path = ::Pirate.gangway.join("templates/Vagrantfile_ship")
          contents = Vagrant::Util::TemplateRenderer.render(template_path)
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

        def create_piratefile(box_name=nil, box_url=nil)
          save_path = ::Pirate.haven.join("Piratefile")
          if save_path.exist?
            raise ::Pirate::Errors::PiratefileExistsError, :this_dir => save_path.dirname, :command => 'ship'
          end

          template_path = ::Pirate.gangway.join("templates/Piratefile")
          contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                            :box_name => box_name,
                                                            :box_url => box_url)
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

        def create_vm_yaml(vm_name)
          source = ::Pirate.haven.join(vm_name)
          # TODO: target need to be relative
          target = ::Pirate.haven.join(".")
          if source.exist?
            raise ::Pirate::Errors::SymlinkExistsError, :source => source, :command => 'ship'
          end
          File.symlink('.', source)
        end

      end
    end
  end
end
