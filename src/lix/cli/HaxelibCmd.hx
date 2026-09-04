package lix.cli;

import lix.client.haxe.Switcher;

class HaxelibCmd {
  static function main() {
    final scope = Scope.seek();

    Command.attempt(
      Switcher.ensureNeko(scope.haxeInstallation.neko, Logger.get()), 
      () -> HaxelibCli.exec(scope)
    );
  }
}