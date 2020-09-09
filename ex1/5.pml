/* Model an office where two computer systems are hooked up to a singte printer. Establish
mutual exclusion between the two computer systems using a global variable and atomic
test-and-set operations. Verify that it is never the case that both systems print at the 
same time.*/

bool printer_in_use;
bool A_is_printing;
bool B_is_printing;

proctype A() {
	atomic {
		(!printer_in_use);
		printer_in_use = true
	}
	A_is_printing = true;
	/* System started printing */
	assert(B_is_printing == false);
	/* System finished printing */
	A_is_printing = false;
	printer_in_use = false;
}

proctype B() {
	atomic {
		(!printer_in_use);
		printer_in_use = true
	}
	B_is_printing = true;
	/* System started printing */
	assert(A_is_printing == false);
	/* System finished printing */
	B_is_printing = false;
	printer_in_use = false;
}

init {
	A_is_printing = false;
	B_is_printing = false;
	atomic {
		run A();
		run B()
	}
	(_nr_pr == 1)
}
