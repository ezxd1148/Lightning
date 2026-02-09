# Main file

# Import libraries

import std/[strutils, strformat, asyncnet, asyncdispatch, parseopt]

# Variables and Consts

const
    targetip: string = "192.168.1.163" # assign target ip
    targetport = 80 # assign port
    googleaddr: string = "google.com"
    httpstringtarget: string = "GET / HTTP/1.1\r\nHost: google.com\r\n\r\n"

# Try binding to port 80 using TCP connection

# Creating socket

let # Dont use const as asyncnet cannot be compiled in compile time
    createSocket = newAsyncSocket() # no need to put asyncnet 

#var
    # connectPort = NaN # NaN value needs math library, dont put it. 

echo &"Connecting to {googleaddr}:{targetport}"

try:
    # this will not work whatsoever
    # connectPort = asyncnet.connect(createSocket, "192.168.1.163", 0) # enum will enumerate lists

    waitFor createSocket.connect(googleaddr, Port(targetport)) #waitFor, this will wait for the connectport to complete

    echo "Connection Successful!"

    waitFor createSocket.send(httpstringtarget)

    var outputHTTPS = waitFor createSocket.recvLine()

    echo outputHTTPS

    createSocket.close() #remember to close socket if done
except ValueError, OSError:
    echo "Failed to connect"


