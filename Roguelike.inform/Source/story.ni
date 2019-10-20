"Roguelike Goose" by lizzard


Part 1 - Some rules

Section 1 - Valid directions

A direction is either available or not available. A direction is usually not available. North is available. South is available. East is available. West is available. Down is available.

Section 2 - Create the map dynamically

A room can be picked or unpicked. A room is usually unpicked.

After going to a room:
	if there are more than 12 unvisited rooms:
		[say "Unvisted: [list of unvisited rooms].";]
		if the player is in a room for the first time:
			now the location of the player is picked;
			[say "Unpicked: [list of unpicked rooms].";]
			if there are more than 12 unpicked rooms:
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
			say "[if count is greater than 1] or [end if][way] ([place])". 
	

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

[Implement peck, honk, flap]

[TODO: implement swimming, which may heal HP]

[Classes: Rogue, Witch, Warrior, Bard]

[Stats: Strength, Ferocity, Tenacity, Moxie, Speed]

[HP, damage, healing systems]


Part 3 - Combat system


[combat]

[magic]



Part 4 - Locations

Magnificent ruins is a room. It is picked. The description is "Crumbling stone, trees growing from crevices in the walls, and a narrow staircase leading down into darkness."

After going from Magnificent ruins:
	say "The walls rumble. You can't see the sky anymore!";
	say "The way out of the dungeon has mysteriously closed.";
	now Magnificent Ruins is mapped up of nowhere;
	continue the action;

Dungeon Entrance is down from Magnificent Ruins. The description is "Stone walls, mildewed with glowing stuff, widen into a large bare room."

Webby Corridor is a room. The description is "Dusty ropes of thick spiderweb festoon the walls."

Chamber of Lights is a room. The description is "An uncanny mottled glow emanates from the walls of this high-ceilinged cavern."

Disturbing Hallway is a room. "The angles here, the colors, the feel of the air -- just wrong. Horribly wrong."

Waterfall Pool is a room. "Water pours down from high above, catching on stalactites and glinting in the eerie glow from the walls. A little pool lies underneath."

Marble Halls is a room. "White flowstone gleams in thick curtains on the walls of this magnificent hall."

Lake of Tears is a room.

Jewelled Forest is a room.

Rockslide Cavern is a room.

Uncanny Lair is a room.

Den of Darkness is a room. 

Evil Archives is a room.

Luminous Gardens is a room.

Nasty Passage is a room.

Vault of Vastness is a room.

Glittering Shrine is a room

Chilly Mausoleum is a room.

Crumbling Corridor is a room.

The Hall of Time is a room.


Part 5 - NPCs

A creature is a kind of person. 

A spider, a kobold, a gelatinous cube, a cave snake, a glowering elf, a tentacled horror, a soot sprite, a lumbering mummy, a wispy ghost, and an iridium bat are creatures.

A sleeping dragon is a creature. 

Table of Mobs
creature
spider
kobold
gelatinous cube 
cave snake
iridium bat
glowering elf
tentacled horror
soot sprite
lumbering mummy
wispy ghost

Part 6 - Objects

[TODO: Implement potions]
[TODO: Implement wearables]
[TODO: Implement wieldable weapons]


