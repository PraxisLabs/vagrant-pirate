require 'optparse'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module Pirate
    module Command
      class Fleet < Vagrant.plugin("2", :command)

        def self.synopsis
          "Initializes a new Vagrant environment by creating a Vagrantfile and YAML config files."
        end
        def execute
          options = {}
          opts = OptionParser.new do |opts|
            opts.banner = "Usage: vagrant pirate fleet [box-name] [box-url]"
          end

          # Parse the options
          argv = parse_options(opts)
          return if !argv

          create_vagrantfile
          create_directories
          create_piratefile(argv[0], argv[1])
          create_vm_yaml('vm1')
          create_vm_yaml('vm2')

          @env.ui.info(I18n.t(
            "vagrant.plugins.pirate.commands.fleet.success",
              avail_dir: 'available.d',
              enabled_dir: 'enabled.d',
              local_dir: 'local.d'
            ), :prefix => false)
          # Success, exit status 0
          0
        end

        def create_vagrantfile
          save_path = @env.cwd.join("Vagrantfile")
          if save_path.exist?
            raise ::Pirate::Errors::VagrantfileExistsError, :command => 'fleet'
          end

          template_path = ::Pirate.gangway.join("templates/Vagrantfile_fleet")
          contents = Vagrant::Util::TemplateRenderer.render(template_path)
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

        def create_directories
          ['available.d', 'enabled.d', 'local.d', 'available.d/default'].each do |dir|
            if ::Pirate.haven.join(dir).exist?
              raise ::Pirate::Errors::ConfigDirExistsError, :this_dir => dir, :command => 'fleet'
            end
            Dir.mkdir(dir)
          end
        end

        def create_piratefile(box_name=nil, box_url=nil)
          save_path = ::Pirate.haven.join("available.d/default/Piratefile")
          if save_path.exist?
            raise ::Pirate::Errors::PiratefileExistsError, :this_dir => save_path.dirname, :command => 'fleet'
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
          source = "enabled.d/" + vm_name
          target = "../available.d/default/"
          if ::Pirate.haven.join(source).exist?
            raise ::Pirate::Errors::SymlinkExistsError, :source => source, :command => 'fleet'
          end
          File.symlink(target, source)
          save_path = ::Pirate.haven.join("local.d/" + vm_name + ".yaml")
          if save_path.exist?
            raise ::Pirate::Errors::LocalFileExistsError, :save_path => save_path, :command => 'fleet'
          end
          template_path = ::Pirate.gangway.join("templates/local.yaml")
          contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                            :hostname => vm_name + ".example.com")
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

      end
    end
  end
end
