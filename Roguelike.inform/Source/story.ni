"Roguelike Goose" by lizzard


Use scoring;

When play begins:
    now the right hand status line is
        "[the player's surroundings]";
    now the left hand status line is "[number of visited rooms]/[number of rooms] rooms / [score] points ";
	say "It's a beautiful day in the dungeon, and you are a horrible goose.";
	say "Try typing 'help' for instructions on how to play.";

Part 1 - Some rules for mapping

Section 1 - Valid directions

A direction is either available or not available. A direction is usually not available. North is available. South is available. East is available. West is available. Down is available.

Definition: a direction (called thataway) is viable if the room 
  thataway from the location is a room.

Section 2 - Create the map dynamically

A room can be picked or unpicked. A room is usually unpicked.
A room has a number called tours. 

Mysterious ruins is a room. It is picked. The description is "Stone crumbles in a blasted wasteland. Grey, twisted trees grow from crevices in the walls. A narrow staircase descends into darkness. "

Carry out going:
	say "[one of]You waddle valiantly forth.[or]Your broad foot webs slappity-slap across the dungeon floor.[or]Grimly, you forge ever onward, tail waggling.[or]Hissing a little, you peer from side to side.[or]Grunting with effort, you clamber over the rocky floor.[or]Your beady-eyed glance darts across yet another corridor.[or]Attempting stealth, you stretch out your long and graceful neck.[or]You waddle on, nonchalant.[or]Owning that dungeon, lord of all you survey.[purely at random]";
	

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
	if the player is in the location of a dragon and the dragon is awake and the player is wearing a lanyard or the player is wearing platemail or the player is wearing a headlamp:
		say "The dragon glares at you.";
		say "It growls, 'Creature of the Outerlands!";
		say "'Renounce the evil AirDnD Overlords!!'";
		say "'Cast off your tacky, ridiculously branded garments! ";
		say "What are you, a waddling billboard, or a warrior?";
	if the number of creatures in the Vault of Vastness is greater than 6 and the rainbow dragon is awake and the dragon is not in the Vault of Vastness and the player is not wearing a lanyard and the player is not wearing platemail and the player is not wearing a headlamp:
		say "The dragon stands up, shaking the floor with its vast bulk.";
		say "It says, 'Yeah, OK, I have to hand it to you. Follow me.'";
		say "The dragon mutters a spell. You are sucked into a magical portal!";
		now the dragon is in the Vault of Vastness;
		now the player is in the Vault of Vastness;
		continue the action;
	if the number of creatures in the Vault of Vastness is less than 7 and the rainbow dragon is awake and the dragon is not in the Vault of Vastness:
		say "The dragon looks you up and down and sighs heavily.";
		say "'You look tough, and I've heard good things.";
		say "'But I need more proof of your worth. Go back and keep fighting.";
		say "The dragon falls back asleep.";	
	if the player is in the Vault of Vastness:
		say "You look around. The assembled creatures are waving union placards and megaphones! [line break]They're stomping on torn, bloody AirDnD motivational posters and timesheets!";
		say "'Magnificent, Powerful Goose!' says the dragon.";
		say "We have elected you Boss Monster of the new Dungeon Monster's Union!";
		say "Everyone cheers heartily!! [paragraph break]";
		say "Congratulations. By defeating the oppressed, underpaid, gig-worker monsters of this realm, you have inspired them to unionize!";
		say "You settle happily into your new role as Boss Monster of the Dungeon with your new friends and comrades. [line break]May you defeat many adventurers in future days!";
		say "THE END.";


			
				


	

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
		say "[line break]The water feels so refreshing!.";
		say "Ominous, like a grim battleship, you glide across the crystal waters.";
		increase the current hp of the player by 1;
		now the player is buoyant;
	if the location of the player is Shorehaven:
		say "[line break]The water feels great!";
		say "Ominous, like a grim battleship, you glide across the crystal waters.";
		now the player is buoyant;
		now the player is in Cavern of the Lake of Tears;
		now Cavern of the Lake of Tears is picked;
		let nextroom be a random unpicked room;
		let nextdir be a random available direction (called way);  
		[say "~~~~ next direction will be [nextdir][line break]";]
		change nextdir exit of the location of the player to nextroom; 
		let reverse be the opposite of the way;
		change the reverse exit of nextroom to the location of the player;
		now Cavern of the Lake of Tears is unpicked;
		continue the action;
	otherwise:
		say "There's not enough water here for swimming.";
		stop the action.

		
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
	

[Adds taglines to your inventory for particular things] 		
The print standard inventory rule is not listed in any rulebook. 		
Carry out taking inventory (this is the new print inventory rule):
	say "You are carrying: [line break]";
	list the contents of the player, with newlines, indented, including contents, with extra indentation. 

After printing the name of something (called target) while taking inventory:
    follow the property-aggregation rules for the target. 

The property-aggregation rules are an object-based rulebook.
The property-aggregation rulebook has a list of text called the tagline. 

A first property-aggregation rule for an openable open thing (this is the mention open openables rule):
        add "open" to the tagline. 

A first property-aggregation rule for an openable closed thing (this is the mention closed openables rule):
        add "closed" to the tagline. 

A property-aggregation rule for a closed transparent container which contains nothing (this is the mention empty transparent containers rule):
        add "empty" to the tagline. 

A property-aggregation rule for an open container which contains nothing (this is the mention empty open containers rule):
        add "empty" to the tagline. 

A property-aggregation rule for a lit thing (this is the mention lit objects rule):
        add "providing light" to the tagline. 

A property-aggregation rule for a switched on device (this is the mention devices rule):
        add "switched on" to the tagline. 

A property-aggregation rule for an object that is worn by the player (this is the mention worn objects rule):
	add "worn on [slot]" to the tagline.

A property-aggregation rule for a weapon:
	add "wielded" to the tagline.
	
The last property-aggregation rule (this is the print aggregated properties rule):
	if the number of entries in the tagline is greater than 0:
		say " ([tagline])";
		rule succeeds;
	rule fails. 



Equipment is a kind of thing. Equipment is usually wearable. Equipment has some text called the slot. Equipment has a number called the modifier. Equipment has some text called the stat. 

A weapon is a kind of thing. 

A potion is a kind of edible thing. A potion has a number called mana.

A healing potion is a potion. The description of a healing potion is "A strangely gelatinous substance, glowing faintly green."

A vial of coffee is a potion. The description of a vial of coffee is "A fragile container of tasty looking hot coffee."

A diamond tiara, an AirDnD headlamp, an AirDnD lanyard, an amulet of awesome, AirDnD platemail, and a glittering cloak are equipment. 



After wearing equipment (called E):
	let M be the modifier of E;
	if the stat of E is "ferocity":
		increase the ferocity of the player by M;
	if the stat of E is "strength":
		increase the strength of the player by M;
	
After taking off equipment (called E):
	let M be the modifier of E;
	if the stat of E is "ferocity":
		decrease the ferocity of the player by M;
	if the stat of E is "strength":
		decrease the strength of the player by M;
		


Table of Bad Equipment
equipment	slot	modifier	stat	description
AirDnD lanyard	"neck"	1	"ferocity"	"A bright orange cord with the AirDnD logo printed on it in fluorescent green and a badge that says 'VISITOR'."
AirDnD headlamp	"head"	1	"strength"	"A tin headlamp shining with a little flicker of blue flame."
AirDnD platemail	"body"	1	"strength"	"Cardboard covered with tinfoil, printed with that tacky orange and green logo."


Table of Good Equipment
equipment	slot	modifier	stat	description
diamond tiara	"head"	10	"ferocity"	"Ice, fire, and steel."
glittering cloak	"body"	3	"strength"	"Tough, sleek titanium armor."
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
"This isn't how things are supposed to go in the dungeon!"
"I went to Monster Polytechnic for this?"
"Scare the adventurers, they said, it's easy, the dispatcher said,"
"Level 1 humans only, that's what my boss promised,"
"Oooh, that smarts,"
"Mama always told me never to cross a dungeon picket line,"
"The dispatcher didn't warn us! This is too much!"
"What ARE you?"
"I hate this job. Stupid AirDnD dungeon doesn't even have a bathroom."
"Ow, that's going too far!"
"Yeow! I don't get paid enough for this!"
"Corporate headquarters didn't warn us about this!"
"Ouch! I'm out of here!"
"That's it, I quit! AirDnD can bite my scaly butt!"
"AirDnD sucks! Worst job ever!"
"Arrrgh, I don't make enough on tips to cover the cost of healing potions!"
"Ow, ow ow!!!! I can't afford a cleric. Free MonsterCare for all!"


[magic]

[stats]



Part 5 - NPCs

A creature is a kind of person.  A creature is either working or striking. A creature is usually working.

A creature is either awake or asleep. A creature is usually awake. 

A spider, a giant rat, a grumpy kobold, a gelatinous cube, a cave snake, a glowering elf, a tentacled horror, a soot sprite, a lumbering mummy, a wispy ghost, a confused adventurer, and an iridium bat are creatures.

Assigning attributes is an action applying to one thing. 

When play begins:
	assign attributes;
	
To assign attributes:
	repeat through the Table of Mobs:
		now the max hp of the creature entry is max hp entry;
		now the current hp of the creature entry is current hp entry;
		now the strength of the creature entry is strength entry;
		now the ferocity of the creature entry is ferocity entry;
		now the description of the creature entry is "It looks [description entry].";
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



Table of Mobs
creature	max hp	current hp	strength	ferocity	description
giant rat	5	5	1	1	"like a pushover. Peck it."
spider	15	15	1	1	"nervous"
grumpy kobold	20	20	1	1	"pretty tough for its size"
gelatinous cube	25	25	3	1	"formidible"
cave snake	12	12	2	1	"like it needs its butt kicked"
iridium bat	15	15	3	1	"fierce and fangy"	
glowering elf	25	25	3	2	"combat-ready"
tentacled horror	30	30	4	2	"terrifying"
soot sprite	8	8	1	1	"ridiculous"
lumbering mummy	15	15	2	1	"tattered and clumsy"
confused adventurer	25	25	2	1	"battle-hardened"
wispy ghost	12	12	2	1	"barely even there"



Part 6 - Locations


After going from Mysterious ruins:
	say "The walls rumble. Rocks fall.[line break]";
	say "You can't see the sky anymore![line break]";
	say "There is no way out.";
	now Mysterious Ruins is mapped up of nowhere;
	continue the action;

Dungeon Entrance is down from Mysterious Ruins. The description is "Stone walls, mildewed with glowing stuff, widen into a large cold room. [paragraph break]A large, colorful sign is on the wall."

A trophy case is in Dungeon Entrance. It is a container. It is fixed in place. The description of a trophy case is "An enormous marble trophy case. The front is carved with the motto, 'Vae victis'".

A welcome sign is scenery in Dungeon Entrance. The description of a welcome sign is "A glossy sign in bright orange and virulent green, with a stylized picture of a sword on a pile of money. It says, 'Welcome to your new Dungeon Away From Home! Let AirDnD be your Guide, as we bring you to new depths in Adventuring! *AirDnD*"


Jewelled Forest is a room. "Marvellous columns march down the length of this immense cave. Jewel-like lights shine from deep within."

Cavern of the Lake of Tears is a room. It is unpicked. "A still, deep lake stretches into the distance. It's vast. You can't see the other side."   

An object called the lake is in Cavern of the Lake of Tears. It is scenery. The description of the lake is "Dark waters, a glassy surface. Cool to the toes. Just right for a swim."

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


Webby Corridor is a room. The description is "Dusty ropes of thick spiderweb festoon the walls. [line break]A brightly colored poster peeks out from beneath the webs."

A poster is scenery in Webby Corridor. The description of a poster is "A color painting of a sad looking gnome with a terrible haircut. Above the painting are glowing words, 'MONSTER OF THE MONTH: Dnifter the Half-Bald!' And under it, 'Congrats to our newest Associate Assassin! *AirDnD*'"

Chamber of Lights is a room. The description is "An uncanny mottled glow emanates from the walls of this high-ceilinged cavern. [line break]An orange and green motto, made of eerie light, floats in the air."

A motto is scenery in Chamber of Lights. The description of a motto is "Fancy calligraphy that says, 'Beat, Slay, Shove. *AirDnD* Your Dungeon Away From Home.' ";

Disturbing Hallway is a room. "The angles here, the colors, the feel of the air -- just wrong. Horribly wrong."

Waterfall Cave is a room. "Water pours down from high above, catching on stalactites and glinting in the eerie glow from the walls. A little pool lies underneath."

A pool is in Waterfall Cave. It is scenery. The description of a pool is "Looks refreshing.  Crystal clear. Maybe you should have a swim!"

Marble Halls is a room. "White flowstone gleams in thick curtains on the walls of this magnificent hall. "




Rockslide Cavern is a room. The description is "Boulders have tumbled down on one side of this cave. It's a tight squeeze to get by them."

Uncanny Lair is a room. The description is "Oddly shaped bones are strewn about this rough cave. Some creature made a nest in one corner out of shredded fungus."

Den of Darkness is a room. The description is "The darkness softens, the room is hushed. It's hard to see your way out."



Luminous Gardens is a room. The description is "Mushrooms the size of trees, glowing, are scattered among winding paths. Tiny lightning bugs flit between snow-pale cave blossoms."

Nasty Passage is a room. The description is "A tight squeeze between damp and slimy boulders. There is blood on the ground."


Chilly Mausoleum is a room. The description is "Cold seeps into your bones. Faceless tombs loom overhead. [line break]A tacky orange and green painting hangs on the wall."

A painting is scenery in Chilly Mausoleum. The description of a painting is "A clumsily painted skull over crossed, bloody swords, with gothic lettering that reads, 'See something? Slay something! *AirDnD*"

The Hall of Time is a room. The description is "A long, narrow hall, flickering with light from magefire sconces. The painted walls show the progression of time through planets and stars, sun and moons."


[This can be the final room where everyone meets]
Vault of Vastness is a room. It is picked. The description is "Soaring arches overhead, stone display cases and cubbyholes in the walls. The treasure hall of a dragon, emptied of its loot." 


Part 7 - Objects

[TODO: move object stuff here]
[TODO: Implement wieldable weapons]

Part 8 - Scoring
[TODO: Add in a score command that shows what you have done and what you have left]


Part 9 - Help system

A thing can be examined or unexamined. A thing is usually unexamined. Carry out examining something: now the noun is examined. 

Taking inventory is acting confused. Looking is acting confused. Examining an examined thing is acting confused. 

After acting confused for four turns:
        say "(If you are feeling lost, try typing 'help' for suggestions.)" 


Understand "help" as summoning help. Summoning help is an action applying to nothing. 

Carry out summoning help:
	say "Here's some basic commands you can use in play.[paragraph break]";
	say "You can 'go' in all 8 directions (north, northeast, etc) as well as up and down. [line break] You can also take things, open things, sit on things, and stand up. 'take all' will pick up everything possible in a room.[paragraph break] look: shows you the description of the room you're in [line break]
i:  lists what you are carrying or wearing. Short for 'inventory'  [line break]
n: short for 'go north' [line break]
x: lets you examine something more closely [line break]
x self: look at yourself [line break]
honk, peck, flap, kill: Try them and see what happens! [line break]
wear: put on a wearable object [line break]
remove (or take off): remove a wearable object[line break]
stats: shows your current strength, ferocity, and hit points[line break]
score: shows your current score [line break]"