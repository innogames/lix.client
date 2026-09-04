package lix.client.sources.haxelib;

class Proxy extends haxe.remoting.AsyncProxy<lix.client.sources.haxelib.Repo> {
  #if haxe5
    public function infos(project:String, cb:ProjectInfos->Void) {
      this.__cnx.resolve('infos').call([project], cb);
    }
  #end
}