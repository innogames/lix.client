package lix.cli;

class NekoCmd {
  static function main() {
    final neko = NekoCli.findNeko();

    Command.attempt(
      lix.client.haxe.Switcher.ensureNeko(neko, Logger.get()), 
      () -> NekoCli.exec(neko)
    );
  }
}