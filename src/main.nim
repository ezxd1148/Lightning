# Import libraries

import std/[asyncnet, asyncdispatch, strutils, strformat]

# Variiables and consts

const
    targetip: string = "scanme.nmap.org"

# main

proc scanPort(port: int) {.async.} =

    let client = newAsyncSocket()

    # ensure this runs even if exception
    defer:
        client.close()

    try:
        await client.connect(targetip, Port(port))

        echo &"Port {port} is open!" 

    except ValueError, OSError:
        discard

proc main() {.async.} =
    var futures: seq[Future[void]] = @[]

    for i in 1 .. 100:
        futures.add(scanPort(i))

    await futures.all()

waitFor main()
