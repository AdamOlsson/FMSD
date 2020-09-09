proctype NONDET() {
  do
    :: true -> printf("1\n")
    :: true ; printf("2\n")
    :: printf("3\n")
  od
}

proctype TRUE() {
  if
    :: false -> printf("1\n")
    :: true  -> printf("2\n")
  fi 
}

proctype ELSE() {
  if
    :: false -> printf("1\n")
    :: else  -> printf("2\n")
  fi 
}

/* Can we generalize that else can be replaced by True? 
No, a counter example would be:

if
  :: true -> ...
  :: else -> ...
fi

In this example, only one of the branches will be executed deterministically. This is because else is only executed 
whenever no other guard is true. Had else been interchangeable with with true, the brnahces would have been 
nondeterministically chosen.
*/

bool b;
proctype TRUE2() {
  if
    :: b -> printf("1\n")
    :: true  -> printf("2\n")
  fi 
}

proctype ELSE2() {
  if
    :: b -> printf("1\n")
    :: else  -> printf("2\n")
  fi 
}

init {
	b = true; /* Check with TA what he means with "ghost" variables */
	atomic {
		run TRUE2();
		run ELSE2()
	}
	(_nr_pr == 1);
	assert(b == true || b == false)
}
