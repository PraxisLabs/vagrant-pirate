module Pirate
  # The source root is the path to the root directory of the this gem.
  def self.gangway
    @gangway ||= Pathname.new(File.expand_path('../../../', __FILE__))
  end

  # The project root directory.
  # TODO: can we retrive this from Vagrant::Environment?
  def self.haven
    @haven ||= Pathname.new(Dir.pwd)
  end

  # Apply settings loaded from YAML to a vm.
  def self.ahoy!(vm,yml)
    yml.each do |key0,value0|
      if !value0.is_a?(Hash)                           # If it's a setting,
          vm.send("#{key0}=".to_sym, value0)           # we set it directly.
      else                                               # Otherwise,
        method_object = vm.method("#{key0}".to_sym)      # we're invoking a method
        value0.each do |key1,value1|                     # and each setting
          method_object.call("#{key1}".to_sym, value1)   # needs to be passed to the method.
        end
      end
    end
  end

  # Merge hashes recursively
  def self.sail_ho!(first, second)
    second.each_pair do |k,v|
      if first[k].is_a?(Hash) and second[k].is_a?(Hash)
        sail_ho!(first[k], second[k])
      else
        first[k] = second[k]
      end
    end
  end

  # Define our config directories
  def self.get_map(plunder)
    dirs = {}
    # Set defaults
    dirs['local'] = ::Pirate.haven.join('local.d')
    dirs['enabled'] = ::Pirate.haven.join('enabled.d')
    # Override defaults with config, if it's set, since config finalizing
    # occurs too late for our purposes.
    if plunder.pirate.map.is_a?(Hash)
      if plunder.pirate.map.has_key?('local')
        dirs['local'] = ::Pirate.haven.join(plunder.pirate.map['local'])
      end
      if plunder.pirate.map.has_key?('enabled')
        dirs['enabled'] = ::Pirate.haven.join(plunder.pirate.map['enabled'])
      end
    end

    if not dirs['local'].directory?
      raise Errors::ConfigDirMissing, :label => 'local', :missing_dir => dirs['enabled']
    end
    if not dirs['enabled'].directory?
      raise Errors::ConfigDirMissing, :label => 'enabled',:missing_dir => dirs['enabled']
    end

    return dirs
  end

  def self.Arrr!(plunder)
    require "yaml"

    # Get our config directories
    map = ::Pirate.get_map(plunder)

    # Scan our enabled.d/ directory for YAML config files
    config_files = Dir.glob(map['enabled'] + "*.yaml")

    # Build up a list of the VMs we'll provision, and their config_files
    vms = {}
    config_files.each do |config_file|
      vms.update({ File.basename(config_file, ".yaml") => config_file})
    end

    # VM-specific configuration loaded from YAML config files
    vms.each do |vm,config_file|

      yml = YAML.load_file config_file
      yml = {} if !yml.is_a?(Hash)

      # Allow local overrides
      local_file = map['local'] + "#{vm}.yaml"
      if File.exists?(local_file)
        local = YAML.load_file local_file
        sail_ho!(yml, local) if local.is_a?(Hash)
      end

      plunder.vm.define "#{vm}" do |vm_config|
        ahoy!(vm_config.vm, yml)
        # We may need some project-wide config file to handle things like:
        #vm_config.vbguest.auto_update = false
      end

    end

  end
end
