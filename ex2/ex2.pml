chan com = [0] of {byte}
byte value = 0;

proctype p() {

  byte i = 0;

  do
  :: if
     :: i >= 5 -> break
     :: else   -> printf("Doing something else\n");
                  i ++
     fi
  :: com ? value ;
     printf("p received: %d\n",value)
  od

}

init {

  atomic {
    run p()
  }

  end:
  com ! 100;

}

/* Yes, due to nondetermism there is a chance that the first branch of the do-loop executes 5 times in a row
    which would break the loop and never read the channel. */