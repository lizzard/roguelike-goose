"Roguelike Goose" by lizzard


Use scoring;

When play begins:
    now the right hand status line is
        "[the player's surroundings]";
    now the left hand status line is "[number of visited rooms]/[number of rooms] rooms / [score] points ";

Part 1 - Some rules for mapping

Section 1 - Valid directions

A direction is either available or not available. A direction is usually not available. North is available. South is available. East is available. West is available. Down is available.

Definition: a direction (called thataway) is viable if the room 
  thataway from the location is a room.

Section 2 - Create the map dynamically

A room can be picked or unpicked. A room is usually unpicked.
A room has a number called tours. 

Mysterious ruins is a room. It is picked. The description is "Stone crumbles in a blasted wasteland. Grey, twisted trees grow from crevices in the walls. A narrow staircase descends into darkness. "

Carry out going to a visited room:
	say "You're going to a VISITED room.[line break]";
	continue the action;
	

After going to a room (called the source):
	if the player is buoyant:
		say "You get out of the water.";
		now the player is walking;
	if there are more than 0 unvisited rooms:
		[say "Unvisted: [list of unvisited rooms][line break].";]
		[say "You are in [the location of the player][line break]";	]
		[say "The number of viable directions is [number of viable directions].";	]	
		if the number of viable directions is less than 2 and the location of the player is unpicked:
			[say "You are in [the location of the player] for the FIRST time[line break]";]
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
							say "removing [way] because you just came from there [line break]";
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
				if a random chance of 2 in 10 succeeds:
					unless Table of Magical Consumables is empty:
						choose a random row from the Table of Magical Consumables;
						now potion entry is in the location of the player;
						blank out the whole row;
				if there are more than 10 unpicked rooms:
					if a random chance of 3 in 10 succeeds:
						unless Table of Bad Equipment is empty:
							choose a random row from the Table of Bad Equipment;
							now equipment entry is in the location of the player;
							blank out the whole row;
				if there are fewer than 10 unpicked rooms:
					if a random chance of 3 in 10 succeeds:
						unless Table of Good Equipment is empty:
							choose a random row from the Table of Good Equipment;
							now equipment entry is in the location of the player;
							blank out the whole row;						
			[now reset the list of available directions]
				now North is available;
				now South is available; 
				now East is available;
				now West is available;
				now Down is available;
				continue the action;
			otherwise:
				if the number of viable directions is less than 2 and the number of unpicked rooms is less than 1:
					say "You have reached a dead end.";
					now a rainbow dragon is in the location of the player;
					say "Something stirs in the darkness.";
		continue the action;
						

Section 3 - Exit related stuff

[Show exits after room description]

Every turn:
	if the location of the player is not Shorehaven:
		let place be location;
		let count be 0;
		say "Exits: ";
		repeat with way running through directions:
			let place be the room way from the location;
			if place is a room:
				increment count;			
				say "[if count is greater than 1] or [end if][way] ([place])";
		say "[line break]"; 
		if the number of creatures in the Vault of Vastness is greater than 5 and the rainbow dragon is awake and the dragon is not in the Vault of Vastness:
			say "The dragon stands up, shaking the floor with its vast bulk.";
			say "It says, 'You're pretty tough for a goose. Follow me.'";
			say "The dragon mutters a spell. You are sucked into a magical portal!";
			now the dragon is in the Vault of Vastness;
			now the player is in the Vault of Vastness;
			continue the action;


	

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
			say "[if count is greater than 1] or [end if][bold type][way][roman type] ([place])";


Part 2 - Our friend Goose

Section 1 - Stats

The description of yourself is "You crane your long, graceful neck to look back. [line break]White, muscular, hefty, feathered. [line break]Yes, you're still a fabulous goose!" 


[Stats: Strength, Ferocity, Cunning]

The max hp of the player is 10. The current hp of the player is 10. The strength of the player is 3.  The ferocity of the player is 2.

Listing stats is an action applying to nothing. 
Understand "stats" as listing stats. 

Carry out listing stats:
	say "Strength: [strength of the player]   Ferocity: [ferocity of the player]   HP: [current hp of the player]/[max hp of the player] [paragraph break]";


Section 2 - Things a goose can do

A person can be floating, buoyant, walking, or hopping. A person is usually walking.

Understand "swim" as swimming. Swimming is an action applying to nothing.

Instead of swimming:
	if the location of the player is Cavern of the Lake of Tears or the location of the player is Waterfall Cave:
		say "[line break]The water feels great!";
		say "Ominous, like a grim battleship, you glide across the crystal waters.";
		now the player is buoyant;
	if the location of the player is Shorehaven:
		say "[line break]The water feels great!";
		say "Ominous, like a grim battleship, you glide across the crystal waters.";
		now the player is buoyant;
		now the player is in Cavern of the Lake of Tears;
		now Cavern of the Lake of Tears is picked;
		let nextroom be a random unpicked room;
		let nextdir be a random available direction (called way);  
		say "~~~~ next direction will be [nextdir][line break]";
		change nextdir exit of the location of the player to nextroom; 
		let reverse be the opposite of the way;
		change the reverse exit of nextroom to the location of the player;
		now Cavern of the Lake of Tears is unpicked;
	continue the action;
		[if the location of the player is Cavern of the Lake of Tears:
			now Shorehaven is mapped west of Cavern of the Lake of Tears;
			say "You notice a little beach to the west.";
			stop the action.]
		
[maybe implement fly or levitate from potions]

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
		say "[one of]A shower of dust cascades from above.[or]Echoes reverberate through the darkness.[or]As ever, the sound of your magnificent honkitude utterly charms you.[then purely at random]".

			
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


Instead of sleeping:
	if the actor is the player:
		say "You take a quick snooze and wake up again, feeling frisky.";
		stop the action.
		
Instead of waking a rainbow dragon:
	say "You sidle up to the dragon and give it a little nudge.";
	now the rainbow dragon is awake;
	say "The dragon wakes up. It yawns hugely.";
	stop the action.
	
Instead of attacking a rainbow dragon:
	if the rainbow dragon is asleep:
		say "You sidle up to the dragon and give it a little nudge.";
		now the rainbow dragon is awake;
		say "The dragon wakes up. It yawns hugely.";
	otherwise:
		say "You stretch out your neck to attack the dragon, then reconsider.";
		say "The dragon looks at you.";
		stop the action.
	

[Classes: Rogue, Witch, Warrior, Bard]


Part 3 - Wearing and wielding

Listing equipment is an action applying to nothing.

Understand "equipment", "equip" or "eq" as listing equipment. 

Carry out listing equipment:
	say "You are wearing: [line break]";
	list the contents of the player, with newlines, indented, including contents, with extra indentation. 
	
Instead of taking inventory: 
	if the number of things enclosed by the player is 0, say "You are empty-beaked." instead; 
	if the player carries something: 
		now all things enclosed by the player are unmarked for listing; 
		now all things carried by the player are marked for listing; 
		say "You are carrying: [line break]"; 
		list the contents of the player, with newlines, indented, giving inventory information, including contents, with extra indentation, listing marked items only; 
	if the player wears something: 
		now all things enclosed by the player are unmarked for listing; 
		now all things worn by the player are marked for listing; 
		say "You are wearing: [line break]"; 
		list the contents of the player, with newlines, indented, including contents, with extra indentation, listing marked items only.


Equipment is a kind of thing. Equipment is usually wearable. Equipment has some text called the slot. Equipment has a number called the modifier. Equipment has some text called the stat. 

A potion is a kind of edible thing. A potion has a number called mana.

A healing potion is a potion. [The mana of a healing potion is 3. ]
A vial of coffee is a potion. 

A diamond tiara, an AirDnD headlamp, an AirDnD lanyard, an amulet of awesome, AirDnD platemail, and glittering chainmail are equipment. 

Table of Bad Equipment
equipment	slot	modifier	stat	description
AirDnD lanyard	"neck"	1	"ferocity"	"A bright orange cord with the AirDnD logo printed on it in fluorescent green and a badge that says 'VISITOR'."
AirDnD headlamp	"head"	1	"strength"	"A tin headlamp shining with a little flicker of blue flame."
AirDnD platemail	"body"	1	"strength"	"Cardboard covered with tinfoil, printed with that tacky orange and green logo."


Table of Good Equipment
equipment	slot	modifier	stat	description
diamond tiara	"head"	10	"ferocity"	"Ice, fire, and steel."	
glittering chainmail	"body"	3	"strength"	"Tough, sleek titanium armor."
amulet of awesome	"neck"	3	"strength"	"A golden amulet that spells out the word 'AWESOME' in flowing script."


Table of Magical Consumables
potion	mana	
a healing potion	3	
a healing potion	4	
a healing potion	5
a vial of coffee	2
a vial of coffee	3
	

After eating a healing potion:
	increase the current hp of the player by the mana;
	say "You feel more vigorous!";
	
After eating a vial of coffee:
	increase the strength of the player by the mana;
	say "You feel mighty!";
	
Understand "drink [potion]"  and "quaff [potion]" as eating.
	

	


Part 4 - Combat system

A person has a number called max hp. A person has a number called current hp. A person has a number called strength. A person has a number called ferocity. 

[combat]

The block attacking rule is not listed in the check attacking rulebook.

Carry out attacking someone:
	repeat with attacks running from 1 to the ferocity of the player:
		let the damage be a random number between the strength of the player and the max hp of the player;
		say "You viciously peck [the noun], causing [damage] points of damage!";
		decrease the current hp of the noun by the damage;
		if the current hp of the noun is less than 0:
			say "[line break][The noun] [one of]falls over, gasping in pain.[or]trips and falls.[or]leaps back in shock.[purely at random]";
			choose a random row from the Table of Complaints;
			say "'[plaint entry]'[one of] it yells.[or] it whines, cringing.[or] it shrieks, scuttling away.[or] it mutters as it turns to run.[or] it mutters.[or] it shrieks.[or] it yelps.[purely at random]";
			say "[The noun] drags itself off into the darkness.";
			now the noun is in the Vault of Vastness;
			increment the score;
			stop the action;
	say "[line break]";
	repeat with attacks running from 1 to the ferocity of the noun:
		let the maxdam be the strength of the noun plus 2;
		let the enemy damage be a random number between the strength of the noun and the maxdam;
		say "[The noun] attacks you, causing [enemy damage] points of damage!";
		decrease the current hp of the player by the enemy damage;
		if the current hp of the player is less than 1:
			say "[line break]You swoon.";
			say "The world shimmers and whirls.";
			say "You wake up nestled into a hollow of warm sand.";
			say "You feel completely healed after your nap.";
			now the current hp of the player is the max hp of the player;
			now the player is in Shorehaven;
			continue the action;

[Silly things the mobs say when they are defeated]
Table of Complaints
Plaint
"This isn't how things are supposed to go!"
"I went to Monster Polytechnic for this?"
"Scare the adventurers, they said, it's easy, they said,"
"Level 1 humans only, that's what they promised,"
"Oooh, that smarts,"
"Mama always told me never to cross a dungeon picket line,"
"The dispatcher didn't warn us! This is too much!"
"What ARE you?"
"Ow, that's going too far!"
"Ouch! I'm out of here!"
"That's it, I quit!"

[magic]

[stats]



Part 5 - NPCs

A creature is a kind of person.  A creature is either working or striking. A creature is usually working.

A creature is either awake or asleep. A creature is usually awake. 

A spider is a creature. 
A grumpy kobold is a creature. 
A gelatinous cube is a creature. 
A cave snake, a glowering elf, a tentacled horror, a soot sprite, a lumbering mummy, a wispy ghost, a confused adventurer, and an iridium bat are creatures.

Assigning stats is an action applying to one thing. 

When play begins:
	assign stats;
	
To assign stats:
	repeat through the Table of Mobs:
		now the max hp of the creature entry is max hp entry;
		now the current hp of the creature entry is current hp entry;
		now the strength of the creature entry is strength entry;
		now the ferocity of the creature entry is ferocity entry;
	repeat through the Table of Magical Consumables:
		now the mana of the potion entry is mana entry;
	repeat through the Table of Bad Equipment:
		now the slot of the equipment entry is slot entry;
		now the modifier of the equipment entry is modifier entry;
		now the stat of the equipment entry is stat entry;
		now the description of the equipment entry is description entry;
	repeat through the Table of Good Equipment:
		now the slot of the equipment entry is slot entry;
		now the modifier of the equipment entry is modifier entry;
		now the stat of the equipment entry is stat entry;
		now the description of the equipment entry is description entry;
		


A rainbow dragon is a creature. The max hp of a rainbow dragon is 40. The current hp of a rainbow dragon is 40. The strength of a rainbow dragon is 3. The ferocity of a rainbow dragon is 3. A rainbow dragon is asleep. The description of a rainbow dragon is "Iridescent scales armor this enormous [if the dragon is asleep]sleeping [end if]dragon.";

A giant rat is a creature. It is in Dungeon Entrance.
The max hp of the giant rat is 5. The current hp of the giant rat is 5. The strength of a giant rat is 1. The ferocity of a giant rat is 1.

Table of Mobs
creature	max hp	current hp	strength	ferocity
spider	15	15	1	1
grumpy kobold	20	20	1	1
gelatinous cube	25	25	3	1
cave snake	12	12	2	1
iridium bat	15	15	3	1
glowering elf	25	25	3	2
tentacled horror	30	30	4	2
soot sprite	8	8	1	1
lumbering mummy	15	15	2	1
confused adventurer	25	25	2	1
wispy ghost	12	12	2	1



Part 6 - Locations


After going from Mysterious ruins:
	say "The walls rumble. Rocks fall.[line break]";
	say "You can't see the sky anymore![line break]";
	say "There is no way out.";
	now Mysterious Ruins is mapped up of nowhere;
	continue the action;

Dungeon Entrance is down from Mysterious Ruins. The description is "Stone walls, mildewed with glowing stuff, widen into a large bare room."

A trophy case is in Dungeon Entrance. It is a container. It is fixed in place. The description of a trophy case is "An enormous marble trophy case. The front is carved with the motto, 'Vae victis'".



Jewelled Forest is a room. "Marvellous columns march down the length of this immense cave. Jewel-like lights shine from deep within."

Cavern of the Lake of Tears is a room. It is unpicked. "A still, deep lake stretches into the distance. It's vast. You can't see the other side."   

An object called the lake is in Cavern of the Lake of Tears. It is scenery.

[Before going to the Cavern of the Lake of Tears:
	now nowhere is mapped west of Cavern of the Lake of Tears;
	continue the action. ]
	
Shorehaven is a room. It is picked. The description is "A peaceful, secluded little beach, just the right size for a dungeon-going goose. A good place to tuck your head under your wing for a short nap. Or you can swim out into the lake.";
[you appear here if you faint in combat, and being here restores your hit points]



Evil Archives is a room. The description is "Row upon row of moldering tomes, dust, and a sense of forboding fill this underground library."

The Librarian's Lair is a room. It is picked. The description is "This is where the librarian lived, ate, slept, and piled their mildew infested spellbooks to the ceiling. It smells horrible."


Glittering Shrine is a room. The description is "Flecks of shining mica gleam from granite walls."

An obsidian altar is an object in Glittering Shrine. The altar is a supporter. It is fixed in place. The description is "A slab of black glass forms an altar along one wall. An inscription runs along its rim."

An inscription is scenery in Glittering Shrine. The description is "It says, in shimmering black letters, 'Sphinx of black quartz, judge my vow.'"

Vault of Secrets is a room. It is picked. The description is "Stone doors swing open. A vault full of shadows and agony lies before you."


Webby Corridor is a room. The description is "Dusty ropes of thick spiderweb festoon the walls."

Chamber of Lights is a room. The description is "An uncanny mottled glow emanates from the walls of this high-ceilinged cavern."

Disturbing Hallway is a room. "The angles here, the colors, the feel of the air -- just wrong. Horribly wrong."

Waterfall Cave is a room. "Water pours down from high above, catching on stalactites and glinting in the eerie glow from the walls. A little pool lies underneath."

A pool is in Waterfall Cave. It is scenery.

Marble Halls is a room. "White flowstone gleams in thick curtains on the walls of this magnificent hall."




Rockslide Cavern is a room. The description is "Boulders have tumbled down on one side of this cave. It's a tight squeeze to get by them."

Uncanny Lair is a room. The description is "Oddly shaped bones are strewn about this rough cave. Some creature made a nest in one corner out of shredded fungus."

Den of Darkness is a room. The description is "The darkness softens, the room is hushed. It's hard to see your way out."



Luminous Gardens is a room. The description is "Mushrooms the size of trees, glowing, are scattered among winding paths. Tiny lightning bugs flit between snow-pale cave blossoms."

Nasty Passage is a room. The description is "A tight squeeze between damp and slimy boulders. There is blood on the ground."


Chilly Mausoleum is a room. The description is "Cold seeps into your bones. Faceless tombs loom overhead."

The Hall of Time is a room. The description is "A long, narrow hall, flickering with light from magefire sconces. The painted walls show the progression of time through planets and stars, sun and moons."


[This can be the final room where everyone meets]
Vault of Vastness is a room. It is picked. The description is "Soaring arches overhead, stone display cases and cubbyholes in the walls. The treasure hall of a dragon, emptied of its loot." 


Part 7 - Objects




[TODO: Implement potions]
[TODO: Implement wearables]
[TODO: Implement wieldable weapons]


Part 8 - Score

[add in a score for creatures striking]

