
# NTRIP Server

(c) German Federal Agency for Cartography and Geodesy (BKG), 2002-2007

NTRIP
-----
The ntripserver is a HTTP client based on "Networked Transport of 
RTCM via Internet Protocol" (NTRIP). This is an application-level 
protocol streaming Global Navigation Satellite System (GNSS) data 
over the Internet. 
NTRIP Version 1.0 is a generic, stateless protocol based on the 
Hypertext Transfer Protocol HTTP/1.1. The HTTP objects are 
enhanced to GNSS data streams.

The primary motivation for NTRIP Version 2.0 is to develop a fully
HTTP-compatible Internet protocol standard that would work with proxy
servers and to add an optional data transport via UDP. Hence, one
NTRIP Version 2.0 transport approach is still based on HTTP1.1 on top
of TCP. The second NTRIP Version 2.0 transport approach is based on
both, the Internet Standard Protocol RTSP (Real Time Streaming Protocol)
for stream control on top of TCP and the Internet Standard Protocol RTP
(Real Time Transport Protocol) for data transport on top of
connectionless UDP.

NTRIP is designed for disseminating differential correction data 
(e.g in the RTCM-104 format) or other kinds of GNSS streaming data to
stationary or mobile users over the Internet, allowing simultaneous
PC, Laptop, PDA, or receiver connections to a broadcasting host. NTRIP
supports wireless Internet access through Mobile IP Networks like GSM,
GPRS, EDGE, or UMTS.

NTRIP is implemented in three system software components:
NTRIP clients, NTRIP servers and NTRIP casters. The NTRIP caster is the
actual HTTP server program whereas NTRIP client and NTRIP server are
acting as HTTP clients.


ntripserver
-----------
The program ntripserver is designed to provide real-time data
from a single NTRIP source running under a POSIX operating system.

Basically the ntripserver grabs a GNSS byte stream (Input, Source)
from either

1. a Serial port, or
2. an IP server, or
3. a File, or
4. a SISNeT Data Server, or
5. a UDP server, or
6. an NTRIP Version 1.0 Caster

and forwards that incoming stream to either

1. an NTRIP Version 2.0 Caster via TCP/IP (Output, Destination), or
2. an NTRIP Version 2.0 Caster via RTSP/RTP (Output, Destination), or
3. an NTRIP Version 2.0 Caster via plain UDP (Output, Destination), or
4. an NTRIP Version 1.0 Caster.

Please note, the options to support NTRIP Version 2.0 are currently still 
under development and should be used with care. Keep in mind that details
of the NTRIP Version 2.0 transport protocol are still under discussion
and may be changed.


Installation
------------
To install the program run

- gunzip ntripserver.tgz
- tar -xf ntripserver.tar
- make, or 
- make debug (for debugging purposes).

To compile the source code on a Windows system where a mingw gcc
compiler is available, you may like to run the following command:

- gcc -Wall -W -O3 -DWINDOWSVERSION ntripserver.c -DNDEBUG 
  -o ntripserver -lwsock32, or
- mingw32-make, or 
- mingw32-make debug

The exacutable will show up as ntripserver on Linux
or ntripserver.exe on a Windows system.

Usage
-----
The user may call the program with the following options:

```bash
-h|? print this help screen

-E <ProxyHost>       Proxy server host name or address, required i.e. when
                     running the program in a proxy server protected LAN,
                     optional
-F <ProxyPort>       Proxy server IP port, required i.e. when running
                     the program in a proxy server protected LAN, optional
-R <maxDelay>	      Reconnect mechanism with maximum delay between reconnect
                     attemts in seconds, default: no reconnect activated,
                     optional

-M <InputMode> Sets the input mode (1 = Serial Port, 2 = IP server,
   3 = File, 4 = SISNeT Data Server, 5 = UDP server, 6 = NTRIP Caster),
   mandatory

   <InputMode> = 1 (Serial Port): (using 8-N-1 = data bits-parity-stop bits)
   -i <Device>       Serial input device, default: /dev/gps, mandatory if
                     <InputMode>=1
   -b <BaudRate>     Serial input baud rate, default: 19200 bps, mandatory
                     if <InputMode>=1
   -f <InitFile>     Name of initialization file to be send to input device,
                     optional

   <InputMode> = 2|5 (IP port | UDP port):
   -H <ServerHost>   Input host name or address, default: 127.0.0.1,
                     mandatory if <InputMode> = 2|5
   -P <ServerPort>   Input port, default: 1025, mandatory if <InputMode>= 2|5
   -f <ServerFile>   Name of initialization file to be send to server,
                     optional
   -x <ServerUser>   User ID to access incoming stream, optional
   -y <ServerPass>   Password, to access incoming stream, optional
   -B                Bind to incoming UDP stream, optional for <InputMode> = 5

   <InputMode> = 3 (File):
   -s <File>	     File name to simulate stream by reading data from (log)
                     file, default is /dev/stdin, mandatory for <InputMode> = 3

   <InputMode> = 4 (SISNeT Data Server):
   -H <SisnetHost>   SISNeT Data Server name or address,
                     default: 131.176.49.142, mandatory if <InputMode> = 4
   -P <SisnetPort>   SISNeT Data Server port, default: 7777, mandatory if
                     <InputMode> = 4
   -u <SisnetUser>   SISNeT Data Server user ID, mandatory if <InputMode> = 4
   -l <SisnetPass>   SISNeT Data Server password, mandatory if <InputMode> = 4
   -V <SisnetVers>   SISNeT Data Server Version number, options are 2.1, 3.0
                     or 3.1, default: 3.1, mandatory if <InputMode> = 4

   <InputMode> = 6 (NTRIP Version 1.0 Caster):
   -H <SourceHost>   Source caster name or address, default: 127.0.0.1,
                     mandatory if <InputMode> = 6
   -P <SourcePort>   Source caster port, default: 2101, mandatory if
                     <InputMode> = 6
   -D <SourceMount>  Source caster mountpoint for stream input, mandatory if
                     <InputMode> = 6
   -U <SourceUser>   Source caster user Id for input stream access, mandatory
                     for protected streams if <InputMode> = 6
   -W <SourcePass>   Source caster password for input stream access, mandatory
                     for protected streams if <InputMode> = 6

-O <OutputMode> Sets output mode for communatation with destination caster
   1 = http: NTRIP Version 2.0 Caster in TCP/IP mode
   2 = rtsp: NTRIP Version 2.0 Caster in RTSP/RTP mode
   3 = ntrip1: NTRIP Version 1.0 Caster
   4 = udp: NTRIP Version 2.0 Caster in Plain UDP mode
   optional

   Defaults to NTRIP1.0, but will change to 2.0 in future versions
   Note that the program automatically falls back from mode rtsp to mode http and
   further to mode ntrip1 if necessary.

   -a <DestHost>     Destination caster name or address, default: 127.0.0.1,
                     mandatory
   -p <DestPort>     Destination caster port, default: 2101, mandatory
   -m <DestMount>    Destination caster mountpoint for stream upload,
                     mandatory
   -n <DestUser>     Destination caster user ID for stream upload to
                     mountpoint, only for NTRIP Version 2.0 destination
                     casters, mandatory
   -c <DestPass>     Destination caster password for stream upload to
                     mountpoint, mandatory
   -N <STR-record>   Sourcetable STR-record
                     optional for NTRIP Version 2.0 in RTSP/RTP and TCP/IP mode
```

Example1: Reading from serial port and forward to NTRIP Version 1.0 Caster:

```bash
./ntripserver -M 1 -i /dev/ttys0 -b 9600 -O 2 -a www.euref-ip.net -p 2101 -m Mount2 
              -n serverID -c serverPass
```

Example2: Reading from NTRIP Version 1.0 Caster and forward to NTRIP Version 2.0

```bash
./ntripserver -M 6 -H www.euref-ip.net -P 2101 -D Mount1 -U clientID -W clientPass
              -O 1 -a www.goenet-ip.fi -p 2101 -m Mount2 -n serverID -c serverPass
```

NTRIP Caster password and mountpoint
------------------------------------
Feeding data streams into the NTRIP system using the ntripserver 
program needs a password (and a user ID for NTRIP Version 2.0)
and one mountpoint per stream.
For the NTRIP Broadcasters EUREF-IP or IGS-IP this is currently 
available from http://igs.bkg.bund.de/index_ntrip_prov.htm 


Disclaimer
----------
Note that this example server implementation is currently an
experimental software. The BKG disclaims any liability nor
responsibility to any person or entity with respect to any loss or
damage caused, or alleged to be caused, directly or indirectly by the
use and application of the NTRIP technology.


Further information
-------------------
URL:    http://igs.bkg.bund.de/index_ntrip.htm
E-mail: euref-ip@bkg.bund.de
