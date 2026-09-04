package lix.client;

import js.node.Buffer;
import js.node.Url;

/**
  Supplies HTTP basic-auth headers for download hosts listed in the user's
  ~/.netrc. Needed because some Haxe libraries are served from an
  authenticated Artifactory repository rather than a public host.
**/
class Auth {

    static function getHostname(url:String):Null<String>
    return
        try Url.parse(url).hostname
        catch (e:Dynamic) null;

    static function getNetrcAuth(hostname:Null<String>):Null<{ login:String, password:String }> {
        if (hostname == null) return null;
        try {
            var entries = js.Lib.require('netrc')();
            var entry = Reflect.field(entries, hostname);
            if (entry != null) {
                var login = Reflect.field(entry, 'login');
                var password = Reflect.field(entry, 'password');
                if (login != null && password != null)
                    return { login: login, password: password };
            }
        }
        catch (e:Dynamic) {}
        return null;
    }

    static function createBasicAuthHeader(login:String, password:String):String
    return 'Basic ' + Buffer.from('$login:$password').toString('base64');

    static public function getAuthHeaders(url:String):Dynamic {
        var headers = {};
        var hostname = getHostname(url);
        if (hostname == null) return headers;
        var auth = getNetrcAuth(hostname);
        if (auth != null)
            Reflect.setField(headers, 'authorization', createBasicAuthHeader(auth.login, auth.password));
        return headers;
    }
}