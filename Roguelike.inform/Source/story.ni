"Roguelike Goose" by lizzard


Part 1 - Some rules

Section 1 - Valid directions

A direction is either available or not available. A direction is usually not available. North is available. South is available. East is available. West is available. Down is available.

Section 2 - Create the map dynamically

A room can be picked or unpicked. A room is usually unpicked.

After going to a room:
	if the player is buoyant:
		say "You get out of the water.";
		now the player is walking;
	if there are more than 0 unvisited rooms:
		[say "Unvisted: [list of unvisited rooms].";]
		if the player is in a room for the first time:
			now the location of the player is picked;
			[say "Unpicked: [list of unpicked rooms].";]
			if there are more than 0 unpicked rooms:
				let nextroom be a random unpicked room;
				[say "~~~~ next room will be [nextroom][line break]";]
	        	   [here i need to exclude the direction player just came from]
				[say "available directions: [list of available directions][line break]";]
				if the location of the player is not Dungeon Entrance:
					repeat with way running through available directions:
						let place be the room way from the location;
						if place is a room:
							[say "removing [way] because you just came from there [line break]";]
							now way is not available;
				[say "available directions: [list of available directions][line break]";]
				let nextdir be a random available direction (called way);  
				[say "~~~~ next direction will be [nextdir][line break]";]
				change nextdir exit of the location of the player to nextroom; 
				let reverse be the opposite of the way;
				change the reverse exit of nextroom to the location of the player;
				[put in a creature!]
				if a random chance of 5 in 10 succeeds:
					unless Table of Mobs is empty:
						choose a random row from the Table of Mobs;
						now creature entry is in the location of the player;
						blank out the whole row;
			[now reset the list of available directions]
				now North is available;
				now South is available; 
				now East is available;
				now West is available;
				now Down is available;
				continue the action;
			otherwise:
				say "You have reached a dead end.";
				now a sleeping dragon is in the location of the player;
				say "Something stirs in the darkness.";

Section 3 - Exit related stuff

[Show exits after room description]

Every turn:
	let place be location;
	let count be 0;
	say "Exits: ";
	repeat with way running through directions:
		let place be the room way from the location;
		if place is a room:
			increment count;			
			say "[if count is greater than 1] or [end if][way] ([place])";
	say "[line break]"; 
	

[It's still nice to have an explicit exit lister command]
			
Listing exits is an action applying to nothing.
Understand "exits" as listing exits.

Carry out listing exits: say "You can go [exit list] from here.".

To say exit list:
	let place be location;
	let count be 0;
	repeat with way running through directions:
		let place be the room way from the location;
		if place is a room:
			increment count;
			say "[if count is greater than 1] or [end if][bold type][way][roman type] ([place])". 


Part 2 - Our friend Goose


The description of yourself is "You crane your long, graceful neck to look back. [line break]White, muscular, hefty, feathered. [line break]Yes, you're still a fabulous goose!" 

[Stats: Strength, Ferocity, Cunning]

[HP, damage, healing systems]

The max hp of the player is 10. The current hp of the player is 10. The str of the player is 3.  The fer of the player is 2.

Listing stats is an action applying to nothing. 
Understand "stats" as listing stats. 

Carry out listing stats:
	say "Strength: [str of the player]   Ferocity: [fer of the player] [paragraph break]";


[implement swimming]

A person can be floating, buoyant, walking, or hopping. A person is usually walking.


Understand "swim" as swimming. Swimming is an action applying to nothing.

Instead of swimming:
	if the location of the player is Cavern of the Lake of Tears or the location of the player is Waterfall Cave:
		say "[line break]The water feels great!";
		say "Ominous, like a grim battleship, you glide across the crystal waters.";
		now the player is buoyant;
		if the location of the player is Cavern of the Lake of Tears:
			now Shorehaven is mapped west of Cavern of the Lake of Tears;
			say "You notice a little beach to the west.";
			stop the action.
		

[Implement peck, honk, flap]
			
Honking is an action applying to nothing. Understand "honk" as honking. 

Carry out honking:
	if the player carries nothing:
		say "HONK!!!!";
	if the player carries something:
		say "HMMMMMNNNNK!!!";
		say "You suddenly remember that your beak is full of stuff.";
			
After honking:
	if more than one person is in the location of the player:
		say "[one of]Startled, a denizen of the dungeon looks up in alarm.[or]A creature nearby jumps in fear.[or]Creatures in the room freeze, scanning for trouble.[then purely at random]";
	otherwise:
		say "[one of]A shower of dust cascades from above.[or]Echoes reverberate through the darkness.[then purely at random]".

			
Flapping is an action applying to nothing. Understand "flap" as flapping. 

After flapping:
	if more than one person is in the location of the player:
		say "[one of]Everyone in the cave starts in surprise.[or]One of your powerful wings clubs a scurrying creature in the elbow.[or]Shadowy crawlers leap away from the chaotic hurricane of your wings.[or]Your flurry of wings makes the creature step back in dismay.[then purely at random]";
		
Carry out flapping:
		say "You flap your wings, menacing everything in the near vicinity.";


Pecking is an action applying to one thing. Understand "peck [something]" as pecking. Understand "bite [something]" as pecking.
		
Check pecking:
	if the noun is a person:
		try attacking the noun instead;
		
Carry out pecking:
	say "You jab your beak at [the noun].";




[Classes: Rogue, Witch, Warrior, Bard]




Part 3 - Combat system

A person has a number called max hp. A person has a number called current hp. A person has a number called str. A person has a number called fer. 



[combat]

The block attacking rule is not listed in the check attacking rulebook.

Carry out attacking someone:
	repeat with attacks running from 1 to the fer of the player:
		let the damage be a random number between the str of the player and the max hp of the player;
		say "You attack [the noun], causing [damage] points of damage!";
		decrease the current hp of the noun by the damage;
		if the current hp of the noun is less than 0:
			say "[line break][The noun] falls over, gasping in pain. It drags itself off into the darkness.";
			now the noun is nowhere;
			stop the action;
	say "[line break]";
	repeat with attacks running from 1 to the fer of the noun:
		let the maxdam be the str of the noun plus 2;
		let the enemy damage be a random number between the str of the noun and the maxdam;
		say "[The noun] attacks you, causing [enemy damage] points of damage!";
		decrease the current hp of the player by the enemy damage;
		if the current hp of the player is less than 0:
			say "[line break]You swoon.";
			say "The world shimmers and whirls.";
			say "You wake up nestled into a hollow of warm sand.";
			say "You feel completely healed after your nap.";
			now the current hp of the player is the max hp of the player;
			now the player is in Shorehaven;
			continue the action;

[magic]

[stats]



Part 4 - Locations


Magnificent ruins is a room. It is picked. The description is "Stone crumbles in a blasted wasteland. Grey, twisted trees grow from crevices in the walls. A narrow staircase descends into darkness. "

After going from Magnificent ruins:
	say "The walls rumble. Rocks fall.[line break]";
	say "You can't see the sky anymore![line break]";
	say "There is no way out.";
	now Magnificent Ruins is mapped up of nowhere;
	continue the action;

Dungeon Entrance is down from Magnificent Ruins. The description is "Stone walls, mildewed with glowing stuff, widen into a large bare room."

Webby Corridor is a room. The description is "Dusty ropes of thick spiderweb festoon the walls."

Chamber of Lights is a room. The description is "An uncanny mottled glow emanates from the walls of this high-ceilinged cavern."

Disturbing Hallway is a room. "The angles here, the colors, the feel of the air -- just wrong. Horribly wrong."

Waterfall Cave is a room. "Water pours down from high above, catching on stalactites and glinting in the eerie glow from the walls. A little pool lies underneath."

A pool is in Waterfall Cave. It is scenery.

Marble Halls is a room. "White flowstone gleams in thick curtains on the walls of this magnificent hall."


Jewelled Forest is a room. "Marvellous columns march down the length of this immense cavern. Jewel-like lights shine from deep within."

A room called Cavern of the Lake of Tears is west of Jewelled Forest. It is picked. "A still, deep lake stretches into the distance. It's vast. You can't see the other side."   

An object called the lake is in Cavern of the Lake of Tears. It is scenery.

Before going to the Cavern of the Lake of Tears:
	now nowhere is mapped west of Cavern of the Lake of Tears;
	continue the action. 
	
Shorehaven is west of The Cavern of the Lake of Tears. It is picked. The description is "A peaceful, secluded little beach, just the right size for a dungeon-going goose. A good place to tuck your head under your wing for a short nap.";
[you appear here if you faint in combat, and being here restores your hit points]

Rockslide Cavern is a room. The description is "Boulders have tumbled down on one side of this cave. It's a tight squeeze to get by them."

Uncanny Lair is a room. The description is "Oddly shaped bones are strewn about this rough cave. Some creature made a nest in one corner out of shredded fungus."

Den of Darkness is a room. The description is "The darkness softens, the room is hushed. It's hard to see your way out."

Evil Archives is a room. The description is "Row upon row of moldering tomes, dust, and a sense of forboding fill this underground library."

The Librarian's Lair is a room. It is picked. The description is "This is where the librarian lived, ate, slept, and piled their mildew infested spellbooks to the ceiling. It smells horrible."

Luminous Gardens is a room. The description is "Mushrooms the size of trees, glowing, are scattered among winding paths. Tiny lightning bugs flit between snow-pale cave blossoms."

Nasty Passage is a room. The description is "A tight squeeze between damp and slimy boulders. There is blood on the ground."

Vault of Vastness is a room. The description is "Soaring arches overhead, stone display cases and cubbyholes in the walls. The treasure hall of a dragon, emptied of its loot." 

Glittering Shrine is a room. The description is "Flecks of shining mica gleam from granite walls."

An obsidian altar is an object in Glittering Shrine. The altar is a supporter. It is fixed in place. The description is "A slab of black glass forms an altar along one wall."

Vault of Secrets is a room. It is picked. The description is "Stone doors swing open. A vault full of shadows and agony lies before you."

Chilly Mausoleum is a room. The description is "Cold seeps into your bones. Faceless tombs loom overhead."

The Hall of Time is a room. The description is "A long, narrow hall, flickering with light from magefire sconces. The painted walls show the progression of time through planets and stars, sun and moons."




Part 5 - NPCs

A creature is a kind of person. 

A spider is a creature. 
A kobold is a creature. 
A gelatinous cube is a creature. 
A cave snake, a glowering elf, a tentacled horror, a soot sprite, a lumbering mummy, a wispy ghost, a confused adventurer, and an iridium bat are creatures.

Assigning hp is an action applying to one thing. 

When play begins:
	assign hp;
	
To assign hp:
	repeat through the Table of Mobs:
		now the max hp of the creature entry is max hp entry;
		now the current hp of the creature entry is current hp entry;
		now the str of the creature entry is str entry;
		now the fer of the creature entry is fer entry;

A sleeping dragon is a creature. The max hp of a sleeping dragon is 40. The current hp of a sleeping dragon is 40. The str of a sleeping dragon is 3.

A giant rat is a creature. It is in Dungeon Entrance.
The max hp of the giant rat is 5. The current hp of the giant rat is 5. The str of a giant rat is 1. The fer of a giant rat is 1.

Table of Mobs
creature	max hp	current hp	str	fer
spider	6	6	1	1
kobold	8	8	1	1
gelatinous cube	12	12	3	1
cave snake	10	10	2	1
iridium bat	15	15	3	1
glowering elf	20	20	3	2
tentacled horror	25	25	4	2
soot sprite	8	8	1	1
lumbering mummy	10	10	2	1
confused adventurer	15	15	2	1
wispy ghost	12	12	2	1






Part 6 - Objects

[TODO: Implement potions]
[TODO: Implement wearables]
[TODO: Implement wieldable weapons]


