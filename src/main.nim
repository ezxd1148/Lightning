# Main file

# Import libraries

import std/[strutils, strformat, asyncnet, asyncdispatch, parseopt]

# Variables and Consts

const
    targetip: string = "192.168.1.163" # assign target ip
    targetport = 80 # assign port

# Try binding to port 80 using TCP connection

# Creating socket

let # Dont use const as asyncnet cannot be compiled in compile time
    createSocket = newAsyncSocket() # no need to put asyncnet 

#var
    # connectPort = NaN # NaN value needs math library, dont put it. 

echo &"Connecting to {targetip}:{targetport}"

try:
    # this will not work whatsoever
    # connectPort = asyncnet.connect(createSocket, "192.168.1.163", 0) # enum will enumerate lists

    waitFor createSocket.connect(targetip, Port(targetport)) #waitFor, this will wait for the connectport to complete

    echo "Connection Successful!"

    createSocket.close() #remember to close socket if done
except ValueError, OSError:
    echo "Failed to connect"



