# no-sharp-corners-remake

THIS IS A WORK IN PROGRESS. NOT ALL FEATURES ARE CODED YET.

This is a remake of a game I made for a gamejam. I'm hoping to remove all of the bugs and make it playable.
Original Version: https://theophylaktos.itch.io/no-sharp-corners
Remake (this project): https://theophylaktos.itch.io/no-sharp-corners-remake?password=slime

This is a turn-based strategy roguelike where you must rotate the board to move both yourself and your enemies.

How to Play:
	Use WASD to move / rotate the board. After you have used your 3 movement turns,
	then use WASD to select which direction you want to attack in. Select which weapon you want to use
	on the right side of the screen.
	
How this was built (if you're interested):
	The circular grid can be thought of as a 2D array, with each ring representing a row
	and each "degree" around the circle representing a column. Thus, each object (whether that be
	an enemy or a player) is stored in an array. When the player or enemy moves, the array is 
	updated to match the current state of the board.
