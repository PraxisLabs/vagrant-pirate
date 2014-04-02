Feature: Command help text

  In order to learn about commands and usage
  As a user using vagrant-pirate
  I want to see help text for commands and options

  Scenario: Running 'vagrant help'
    When I successfully run `vagrant help`
    Then the output should contain "pirate"
    And the output should contain "Manage YAML-based projects."
    And the output should not contain "pirate-fleet"
    And the output should not contain "pirate-ship"
    And the output should not contain "pirate-update"

  Scenario: Running 'vagrant list-commands'
    When I successfully run `vagrant list-commands`
    Then the output should contain "pirate"
    And the output should contain "Manage YAML-based projects."
    And the output should contain "pirate-fleet"
    And the output should contain "Initializes a new Vagrant environment by creating a Vagrantfile and YAML config files."
    And the output should contain "pirate-ship"
    And the output should contain "Initializes a new Vagrant environment by creating a Vagrantfile and YAML config files."
    And the output should contain "pirate-update"
    And the output should contain "Updates a YAML-based Vagrant environment."

  Scenario: Running 'vagrant pirate'
    When I successfully run `vagrant pirate`
    Then the output should contain "Usage: vagrant pirate <command> [<args>]"
    And the output should contain "Available subcommands:"
    And the output should contain "fleet"
    And the output should contain "ship"
    And the output should contain "update"
    And the output should contain "For help on any individual command run `vagrant pirate COMMAND -h`"

  Scenario: Running 'vagrant pirate fleet -h'
    When I successfully run `vagrant pirate fleet -h`
    Then the output should contain "Usage: vagrant pirate fleet [box-name] [box-url]"
    And the output should contain "-h, --help"
    And the output should contain "Print this help"

  Scenario: Running 'vagrant pirate ship -h'
    When I successfully run `vagrant pirate ship -h`
    Then the output should contain "Usage: vagrant pirate ship [box-name] [box-url]"
    And the output should contain "-h, --help"
    And the output should contain "Print this help"

  Scenario: Running 'vagrant pirate update -h'
    When I successfully run `vagrant pirate update -h`
    Then the output should contain "Usage: vagrant pirate update"
    And the output should contain "-f, --force"
    And the output should contain "Update without confirmation."
    And the output should contain "-h, --help"
    And the output should contain "Print this help"
