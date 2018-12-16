# What is repcached? 
Repcached is patch set which adds data replication feature to memcached. You can read more at: http://repcached.lab.klab.org/ It could be used successfully to achieve high availability for memcached.

# How to use this image? 
If you have 2 servers with working network connection configured as below: 

|Hostname|IP Address|
|--------|----------|
|srv_A|A.A.A.A|
|srv_B|B.B.B.B|

You could start repcached as following:<br> 
On srv_A:<br>
``` docker run -d --restart unless-stopped --name=repcached -e SLAVE="B.B.B.B" -p 127.0.0.1:11211:11211 -p 11212:11212 oktec/repcached:tag ```

On srv_B:<br> 
``` docker run -d --restart unless-stopped --name=repcached -e SLAVE="A.A.A.A" -p 127.0.0.1:11211:11211 -p 11212:11212 oktec/repcached:tag ```

# How to test functionality:

On srv_A:<br> 
``` telnet 127.0.0.1 11211 <br> set Test 0 100 10 JournalDev ```

You should see a message STORED

On srv_B:<br> 
``` telnet 127.0.0.1 11211 <br> get Test ```

You should get a response: VALUE Test 0 10
``` JournalDev <br> END ```

Additionally, you could try to set key/value on srv_B and get it from srv_A.
