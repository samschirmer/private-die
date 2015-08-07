# private-die
Private Die Demo - Mystic Ape Games

This is a super early digital demo of Private Die, a dice-rolling board game by Mystic Ape Games. This is purely CLI at this point, and for the foreseeable future. Works in Ruby 2.1.4 that I know of. 

This is going to be distributed (for free) to backers of our impending Kickstarter campaign to launch the physical version of the board game. 

8/7/2015:
I finished up the player character modules, and all the baseline detectives that will ship with the physical game are now included in this demo. I still have a lot of cleanup to do, as far as the CLI output is concerned. 

7/27/2015:
Added rules and fixed some weird bugs. Also, it turns out that this completely shits itself when you try to run it on an older Mac. It was probably running Ruby 1.9, which I'm not concerned about supporting at this time, but it's something I'm looking into a bit in case it was running 2.0+.

7/22/2015:
I've added a couple more classes (Lucky and Insubordinate), and they've been tested to the point that they're stable. I still need to add a couple more classes to round out the basic game roster, but we still have to work out some rules kinks on the actual game development end. Once we have the final two detective abilities hammered out, I will add them to this digital version.

Added tie handling via roll-offs and cleaned up some of the console output. 
