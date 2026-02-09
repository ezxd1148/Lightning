# Main file

# Import libraries

import std/[strutils, strformat, asyncnet, asyncdispatch, parseopt]

# Variables and Consts

const
    targetip: string = "192.168.1.163" # assign target ip
    targetport = 80 # assign port
    googleaddr: string = "google.com"
    httpstringtarget: string = "GET / HTTP/1.1\r\nHost: google.com\r\n\r\n"

# proc using async test
proc fetchGoogle() {.async.} = # mistake here, used : instead of = for proc
    let client = newAsyncSocket()
    try:
        await client.connect(googleaddr, Port(targetport)) # await only inside async
        
        echo "Connection Successful!"
        await client.send(httpstringtarget)

        var outputHTTPS = await client.recvLine()

        echo outputHTTPS

        client.close()
    except ValueError, OSError:
        echo "Failed to connect"

waitFor fetchGoogle()
