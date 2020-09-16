/*
Model a system having 5 clients and 2 servers where a client cannot
send another request before his previous one was processed by a server. 
The suggested solution uses buffered channels and describes the
behaviour of the server processes. Complete the solution for the client processes.
*/ 

chan request = [2] of { byte, chan};
chan reply[5] = [2] of { byte };

active [2] proctype Server() {
  byte client;
  chan replyChannel;

end:
  do
     :: request ? client, replyChannel ->
        printf("Client %d processed by server %d\n", client, _pid);
        replyChannel ! _pid
  od
}

proctype Client(byte id) {
    byte server;

    request ! id, reply[id];

    nempty(reply[id]); // wait for reply

    reply[id] ? server

    printf("Client %d's request was handled by server %d\n", id, server)

}

init {
    byte no_clients = 5;
    atomic {
        byte i = 0
        do
            :: i >= no_clients -> break
            :: else ->
                run Client(i);
                i++
        od
    }

    (_nr_pr == 3); // init + 2 servers

    atomic {
        byte i = 0
        do
            :: i >= no_clients -> break
            :: else -> assert(empty(reply[i])); i++
        od
    }
}