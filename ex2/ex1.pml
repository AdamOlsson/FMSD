chan myChan = [0] of { byte }

active proctype Sender(){
    byte count = 0;
    do
        :: count > 9 -> break
        :: else ->
            myChan ! count;
            count++
    od
}

active proctype Receiver() {
    byte value;
    end:
    do
        :: myChan ? value ; printf("%d\n", value)
    od  
}