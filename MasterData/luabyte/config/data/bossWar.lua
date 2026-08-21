local title = {
	id = 0,
	name = 0,
	desc = 0,
	type = 0,
	icon = "",
	mission = 0,
	level = 0,
	opentime = {},
	openlanguage = 0,
	bossid = 0,
	blood = 0,
	firstChests = {},
	chest = {}
}

local value = {
[1] =
{
 		id=1,
 		name=29000136,
 		desc=29010136,
 		type=1,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_03",
 		mission=701101,
 		level=1,
 		opentime={1,4,7},
 		openlanguage=1300,
 		bossid=52001,
 		blood=6,
 		firstChests={7011,7012,7013,7014,7015,7016},
 	chest={7511,7512,7513,7514,7515,7516}
},
[2] =
{
 		id=2,
 		name=29000137,
 		desc=29010137,
 		type=2,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_02",
 		mission=701102,
 		level=1,
 		opentime={2,5,7},
 		openlanguage=1301,
 		bossid=52004,
 		blood=6,
 		firstChests={7021,7022,7023,7024,7025,7026},
 	chest={7521,7522,7523,7524,7525,7526}
},
[3] =
{
 		id=3,
 		name=29000135,
 		desc=29010135,
 		type=3,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_01",
 		mission=701103,
 		level=1,
 		opentime={3,6,7},
 		openlanguage=1302,
 		bossid=52007,
 		blood=6,
 		firstChests={7031,7032,7033,7034,7035,7036},
 	chest={7531,7532,7533,7534,7535,7536}
},
[11] =
{
 		id=11,
 		name=29000136,
 		desc=29010136,
 		type=1,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_03",
 		mission=701111,
 		level=2,
 		opentime={1,4,7},
 		openlanguage=1300,
 		bossid=52101,
 		blood=6,
 		firstChests={7111,7112,7113,7114,7115,7116},
 	chest={7611,7612,7613,7614,7615,7616}
},
[12] =
{
 		id=12,
 		name=29000137,
 		desc=29010137,
 		type=2,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_02",
 		mission=701112,
 		level=2,
 		opentime={2,5,7},
 		openlanguage=1301,
 		bossid=52104,
 		blood=6,
 		firstChests={7121,7122,7123,7124,7125,7126},
 	chest={7621,7622,7623,7624,7625,7626}
},
[13] =
{
 		id=13,
 		name=29000135,
 		desc=29010135,
 		type=3,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_01",
 		mission=701113,
 		level=2,
 		opentime={3,6,7},
 		openlanguage=1302,
 		bossid=52107,
 		blood=6,
 		firstChests={7131,7132,7133,7134,7135,7136},
 	chest={7631,7632,7633,7634,7635,7636}
},
[21] =
{
 		id=21,
 		name=29000136,
 		desc=29010136,
 		type=1,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_03",
 		mission=701121,
 		level=3,
 		opentime={1,4,7},
 		openlanguage=1300,
 		bossid=52201,
 		blood=6,
 		firstChests={7211,7212,7213,7214,7215,7216},
 	chest={7711,7712,7713,7714,7715,7716}
},
[22] =
{
 		id=22,
 		name=29000137,
 		desc=29010137,
 		type=2,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_02",
 		mission=701122,
 		level=3,
 		opentime={2,5,7},
 		openlanguage=1301,
 		bossid=52204,
 		blood=6,
 		firstChests={7221,7222,7223,7224,7225,7226},
 	chest={7721,7722,7723,7724,7725,7726}
},
[23] =
{
 		id=23,
 		name=29000135,
 		desc=29010135,
 		type=3,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_01",
 		mission=701123,
 		level=3,
 		opentime={3,6,7},
 		openlanguage=1302,
 		bossid=52207,
 		blood=6,
 		firstChests={7231,7232,7233,7234,7235,7236},
 	chest={7731,7732,7733,7734,7735,7736}
},
[31] =
{
 		id=31,
 		name=29000136,
 		desc=29010136,
 		type=1,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_03",
 		mission=701131,
 		level=4,
 		opentime={1,4,7},
 		openlanguage=1300,
 		bossid=52301,
 		blood=6,
 		firstChests={7311,7312,7313,7314,7315,7316},
 	chest={7811,7812,7813,7814,7815,7816}
},
[32] =
{
 		id=32,
 		name=29000137,
 		desc=29010137,
 		type=2,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_02",
 		mission=701132,
 		level=4,
 		opentime={2,5,7},
 		openlanguage=1301,
 		bossid=52304,
 		blood=6,
 		firstChests={7321,7322,7323,7324,7325,7326},
 	chest={7821,7822,7823,7824,7825,7826}
},
[33] =
{
 		id=33,
 		name=29000135,
 		desc=29010135,
 		type=3,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_01",
 		mission=701133,
 		level=4,
 		opentime={3,6,7},
 		openlanguage=1302,
 		bossid=52307,
 		blood=6,
 		firstChests={7331,7332,7333,7334,7335,7336},
 	chest={7831,7832,7833,7834,7835,7836}
},
[41] =
{
 		id=41,
 		name=29000136,
 		desc=29010136,
 		type=1,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_03",
 		mission=701141,
 		level=5,
 		opentime={1,4,7},
 		openlanguage=1300,
 		bossid=52401,
 		blood=6,
 		firstChests={7411,7412,7413,7414,7415,7416},
 	chest={7911,7912,7913,7914,7915,7916}
},
[42] =
{
 		id=42,
 		name=29000137,
 		desc=29010137,
 		type=2,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_02",
 		mission=701142,
 		level=5,
 		opentime={2,5,7},
 		openlanguage=1301,
 		bossid=52404,
 		blood=6,
 		firstChests={7421,7422,7423,7424,7425,7426},
 	chest={7921,7922,7923,7924,7925,7926}
},
[43] =
{
 		id=43,
 		name=29000135,
 		desc=29010135,
 		type=3,
 		icon="UI/SpritePics/simulation/ui_simulation_boss_img_01",
 		mission=701143,
 		level=5,
 		opentime={3,6,7},
 		openlanguage=1302,
 		bossid=52407,
 		blood=6,
 		firstChests={7431,7432,7433,7434,7435,7436},
 	chest={7931,7932,7933,7934,7935,7936}
}
}

return {title=title, value=value}