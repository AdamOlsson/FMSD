#define N 4 

bool player1;
bool player2;
bool game_on;
int players;

active [N] proctype player() {
	int player_no;
	/* Booking */
	atomic {
		(!player1 || !player2) && players == 0;
		if
			:: !player1 -> player1 = true;
										 player_no = 1
			:: !player2 -> player2 = true;
										 player_no = 2
		fi
	}
	player1 & player2 || game_on; /* Wait for other player */
	game_on = true;
	players++;
	
  /* Start playing game */
	/* Game has ended */

	
	if
		:: player_no == 1 -> player1 = false
		:: player_no == 2 -> player2 = false
	fi

	!player1 & !player2 || !game_on;
	game_on = false;	
	players--;
}
