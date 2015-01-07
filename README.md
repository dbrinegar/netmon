netmon
======

OSX network testing utils for diagnosing what has gone wrong from a Mac.

```
$ brew tap dbrinegar/dbrinegar
$ brew install dbrinegar/dbrinegar/netmon
```

Workers are like [Nagios plugins](http://nagios.sourceforge.net/docs/nagioscore/4/en/pluginapi.html)
in that they do one simple test, print a message, and exit 2 for failure, or 0 for success

* testnet
* testdns
* testntp

Runner script `netmon.sh` prints something like this when things are working:

```
$ netmon.sh
OK network can reach 192.168.254.1
OK network can reach 8.8.8.8
OK dns working on 8.8.8.8
OK dns working on 192.168.254.1
OK dns working on localhost
OK time in sync -35.289 on 192.168.254.1
OK time in sync -85.953 on localhost
```

and can use the `nagios2nljson` formatter to get time series data:

```
$ netmon.sh -j
```
```js
{"status":0, "time":1420587270, "msg":"OK network can reach 192.168.254.1", "cmd":"testnet 192.168.254.1"}
{"status":0, "time":1420587270, "msg":"OK network can reach 8.8.8.8", "cmd":"testnet 8.8.8.8"}
{"status":0, "time":1420587270, "msg":"OK dns working on 8.8.8.8", "cmd":"testdns 8.8.8.8"}
{"status":0, "time":1420587270, "msg":"OK dns working on 192.168.254.1", "cmd":"testdns 192.168.254.1"}
{"status":0, "time":1420587270, "msg":"OK dns working on localhost", "cmd":"testdns localhost"}
{"status":0, "time":1420587270, "msg":"OK time in sync -34.254 on 192.168.254.1", "cmd":"testntp 192.168.254.1"}
{"status":0, "time":1420587270, "msg":"OK time in sync 40.063 on localhost", "cmd":"testntp localhost"}
```
