# TheOtherOne

A spring like prove server for unit test paranoids like me.

## Some Setup

```bash
$ git clone https://github.com/oogatta/TheOtherOne.git
$ cd TheOtherOne
$ cpanm --installdeps . 
```

## Server

```bash
$ cd /any/perl/project/
$ too-server
server started on port 7777.
```

## Client 

```bash
$ cd /any/perl/project/
$ too-client someof/your/cute/unit.t
```

Currently test outputs get printed out to the server's STDOUT.

```bash
$ too-server
server started on port 7777.
received data: t/lib/Oogatta.t
ok, starting tests.

✓    L10: ok(1);

ok

tests finished i guess.
```

At your first run you have to wait the usual warming up time until tests start, but from then they'll fire up with almost zero latency, I hope.

## Goal

This is not what runs massive tests faster, but helps small tests depending on an enormous codebase rise earlier.

> "in some ideal world we would have instant, infallible feedback about our programming decisions" ...
> "every key stroke that I make, if the code is ready to deploy, it would just instantly deploy."
>
> Kent Beck