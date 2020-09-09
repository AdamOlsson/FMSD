byte b = 0;
#define N 5

proctype P() {
	atomic {
		byte tmp = b;
		tmp++;
		b = tmp
	}
}

init {
	int i = 0;
	atomic {
		do
			:: i >= N -> break
			:: else		-> run P();
									 i++
		od
	}

	(_nr_pr == 1);
	assert(0 < b && b <= N);
}
