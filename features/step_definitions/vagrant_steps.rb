Given(/^a Vagrant project directory named "(.*?)"$/) do |dir_name|
  # Running 'vagrant up' (in a subsequent step) will take longer than the
  # default 3 seconds that Aruba allows a process to run. So we set it to
  # 2 minutes, unless it's already explicitely been set with:
  # "Given The default aruba timeout is X seconds"
  @aruba_timeout_seconds ||= 120

  create_dir(dir_name)
  cd(dir_name)

  # We register the directory we'll be running 'vagrant up' in, so that we
  # can 'vagrant destroy' it in our 'After' hook. Since the 'After' hook runs
  # after each scenario, it's safe to re-use a single environment variable.
  # If we ever want to support using this step multiple times in a single
  # scenario, we'll need to re-work this.
  ENV['vagrant_test_dir'] = Pathname.new(Dir.pwd).join(current_dir).to_s

end

After do |scenario|
  if ENV.member?('vagrant_test_dir')
    # chdir's persist within the process, so we'll need to get back where we
    # started.
    orig_dir = Dir.pwd
    # @TODO Print the below calls and their output when @announce is set.
    Dir.chdir(ENV.delete('vagrant_test_dir'))
    `vagrant destroy -f`
    Dir.chdir(orig_dir)
  end
end
