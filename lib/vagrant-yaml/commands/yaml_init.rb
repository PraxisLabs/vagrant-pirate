require 'optparse'
require 'vagrant/util/template_renderer'
require 'vagrant/command/base'

module VagrantYaml
  module Command

    class YamlInit < Vagrant::Command::Base
      def execute
        options = {}

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: vagrant yaml init [box-name] [box-url]"
        end

        # Parse the options
        argv = parse_options(opts)
        return if !argv

        save_path = @env.cwd.join("Vagrantfile")
#    raise Errors::VagrantfileExistsError if save_path.exist?

        template_path = ::Vagrant.source_root.join("templates/commands/init/Vagrantfile")
        contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                          :box_name => argv[0] || "base",
                                                          :box_url => argv[1])

        # Write out the contents
        save_path.open("w+") do |f|
          f.write(contents)
        end

        @env.ui.info(I18n.t("vagrant.plugins.yaml.commands.init.success"),
                     :prefix => false)

        # Success, exit status 0
        0
       end
    end
  end
end

