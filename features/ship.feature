Feature: 'vagrant pirate ship' command

  In order to start using a YAML-based Vagrant project
  As a user using vagrant-pirate
  I want to initialize a new basic project

  Scenario: Running 'vagrant pirate ship'
    Given a directory named "test_ship"
    And I cd to "test_ship"
    When I successfully run `vagrant pirate ship`
    Then the following files should exist:
      | Vagrantfile |
      | Piratefile |
      | vm1 |
    And the output should contain "A `Vagrantfile` and `Piratefile` (YAML VM config file) have been placed in this"

  @up
  Scenario: Running 'vagrant up' after initializing a basic project
    Given a Vagrant project directory named "test_ship_up"
    When I successfully run `vagrant pirate ship`
    And I successfully run `vagrant up`
    And I successfully run `vagrant ssh vm1 -c "hostname -f"`
    Then the output should contain "vm1.example.com"

