Feature: 'vagrant pirate fleet' command

  In order to start using a complex YAML-based Vagrant project
  As a user using vagrant-pirate
  I want to initialize a new full-featured project

  Scenario: Running 'vagrant pirate fleet'
    Given a directory named "test_fleet"
    And I cd to "test_fleet"
    When I successfully run `vagrant pirate fleet`
    Then the following directories should exist:
      | local.d |
      | available.d |
      | available.d/default |
      | enabled.d |
      | enabled.d/vm1 |
      | enabled.d/vm2 |
    And the following files should exist:
      | Vagrantfile |
      | available.d/default/Piratefile |
      | local.d/vm1.yaml |
      | local.d/vm2.yaml |
    And the output should contain "A `Vagrantfile` has been placed in this directory. A default directory containing"

  @up
  Scenario: Running 'vagrant up' after initializing a full project
    Given a Vagrant project directory named "test_fleet_up"
    When I successfully run `vagrant pirate fleet`
    And I successfully run `vagrant up`
    And I successfully run `vagrant ssh vm1 -c "hostname -f"`
    And I successfully run `vagrant ssh vm2 -c "hostname -f"`
    Then the output should contain "vm1.example.com"
    Then the output should contain "vm2.example.com"

