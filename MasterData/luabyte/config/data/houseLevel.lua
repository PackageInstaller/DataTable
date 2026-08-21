local title = {
	id = 0,
	type = 0,
	level = 0,
	num = 0,
	levelCost = {},
	costNum = {},
	showReward = {},
	seatLimit = 0,
	cleanTime = 0,
	makeResult = 0
}

local value = {
[1] =
{
 		id=1,
 		type=1,
 		level=1,
 		num=1,
 	makeResult=0
},
[2] =
{
 		id=2,
 		type=1,
 		level=2,
 		num=1,
 		levelCost={731,701,711,721},
 		costNum={1,1,1,1},
 	makeResult=0
},
[3] =
{
 		id=3,
 		type=1,
 		level=3,
 		num=2,
 		levelCost={731,701,711,721},
 		costNum={1,2,2,2},
 	makeResult=0
},
[4] =
{
 		id=4,
 		type=1,
 		level=4,
 		num=2,
 		levelCost={731,701,711,721},
 		costNum={1,3,3,3},
 	makeResult=0
},
[5] =
{
 		id=5,
 		type=1,
 		level=5,
 		num=3,
 		levelCost={731,702,712,722},
 		costNum={1,2,2,2},
 	makeResult=0
},
[6] =
{
 		id=6,
 		type=1,
 		level=6,
 		num=3,
 		levelCost={731,702,712,722},
 		costNum={1,3,3,3},
 	makeResult=0
},
[7] =
{
 		id=7,
 		type=1,
 		level=7,
 		num=4,
 		levelCost={731,702,712,722},
 		costNum={1,4,4,4},
 	makeResult=0
},
[8] =
{
 		id=8,
 		type=1,
 		level=8,
 		num=4,
 		levelCost={731,703,713,723},
 		costNum={1,3,3,3},
 	makeResult=0
},
[9] =
{
 		id=9,
 		type=1,
 		level=9,
 		num=5,
 		levelCost={731,703,713,723},
 		costNum={1,4,4,4},
 	makeResult=0
},
[10] =
{
 		id=10,
 		type=1,
 		level=10,
 		num=5,
 		levelCost={731,703,713,723},
 		costNum={1,5,5,5},
 	makeResult=0
},
[11] =
{
 		id=11,
 		type=2,
 		level=1,
 		num=2,
 	makeResult=11
},
[12] =
{
 		id=12,
 		type=2,
 		level=2,
 		num=3,
 		levelCost={701,711,721},
 		costNum={1,1,2},
 	makeResult=12
},
[13] =
{
 		id=13,
 		type=2,
 		level=3,
 		num=3,
 		levelCost={701,711,721},
 		costNum={2,2,4},
 	makeResult=13
},
[14] =
{
 		id=14,
 		type=2,
 		level=4,
 		num=4,
 		levelCost={702,712,722},
 		costNum={2,2,4},
 	makeResult=14
},
[15] =
{
 		id=15,
 		type=2,
 		level=5,
 		num=4,
 		levelCost={703,713,723},
 		costNum={2,2,4},
 	makeResult=15
},
[16] =
{
 		id=16,
 		type=2,
 		level=6,
 		num=5,
 		levelCost={704,714,724},
 		costNum={2,2,2},
 	makeResult=16
},
[17] =
{
 		id=17,
 		type=4,
 		level=1,
 	makeResult=0
},
[18] =
{
 		id=18,
 		type=5,
 		level=1,
 		num=1,
 		levelCost={1},
 		costNum={1},
 	makeResult=0
},
[19] =
{
 		id=19,
 		type=6,
 		level=1,
 		num=1,
 		seatLimit=3,
 		cleanTime=7200,
 	makeResult=0
},
[20] =
{
 		id=20,
 		type=6,
 		level=2,
 		num=1,
 		levelCost={701,711,721},
 		costNum={1,1,2},
 		seatLimit=4,
 		cleanTime=6600,
 	makeResult=0
},
[21] =
{
 		id=21,
 		type=6,
 		level=3,
 		num=1,
 		levelCost={701,711,721},
 		costNum={2,2,4},
 		seatLimit=5,
 		cleanTime=6000,
 	makeResult=0
},
[22] =
{
 		id=22,
 		type=6,
 		level=4,
 		num=1,
 		levelCost={702,712,722},
 		costNum={2,2,4},
 		seatLimit=6,
 		cleanTime=5400,
 	makeResult=0
},
[23] =
{
 		id=23,
 		type=6,
 		level=5,
 		num=1,
 		levelCost={703,713,723},
 		costNum={2,2,4},
 		seatLimit=7,
 		cleanTime=4800,
 	makeResult=0
},
[24] =
{
 		id=24,
 		type=6,
 		level=6,
 		num=1,
 		levelCost={704,714,724},
 		costNum={2,2,2},
 		seatLimit=8,
 		cleanTime=4200,
 	makeResult=0
},
[25] =
{
 		id=25,
 		type=7,
 		level=1,
 		num=1,
 	makeResult=0
},
[26] =
{
 		id=26,
 		type=7,
 		level=2,
 		num=1,
 		levelCost={701,711,721},
 		costNum={1,2,1},
 	makeResult=0
},
[27] =
{
 		id=27,
 		type=7,
 		level=3,
 		num=1,
 		levelCost={701,711,721},
 		costNum={2,4,2},
 	makeResult=0
},
[28] =
{
 		id=28,
 		type=7,
 		level=4,
 		num=1,
 		levelCost={702,711,721},
 		costNum={1,2,1},
 	makeResult=0
},
[29] =
{
 		id=29,
 		type=7,
 		level=5,
 		num=1,
 		levelCost={702,712,722},
 		costNum={2,4,2},
 	makeResult=0
},
[30] =
{
 		id=30,
 		type=7,
 		level=6,
 		num=1,
 		levelCost={703,712,722},
 		costNum={1,2,1},
 	makeResult=0
},
[31] =
{
 		id=31,
 		type=7,
 		level=7,
 		num=1,
 		levelCost={703,713,723},
 		costNum={2,4,2},
 	makeResult=0
},
[32] =
{
 		id=32,
 		type=7,
 		level=8,
 		num=1,
 		levelCost={704,714,724},
 		costNum={2,2,2},
 	makeResult=0
},
[33] =
{
 		id=33,
 		type=7,
 		level=9,
 		num=1,
 		levelCost={704,714,724},
 		costNum={4,4,4},
 	makeResult=0
},
[34] =
{
 		id=34,
 		type=8,
 		level=1,
 	makeResult=0
},
[35] =
{
 		id=35,
 		type=8,
 		level=2,
 		levelCost={701,711,721},
 		costNum={1,2,1},
 		showReward={64},
 	makeResult=0
},
[36] =
{
 		id=36,
 		type=8,
 		level=3,
 		levelCost={701,711,721},
 		costNum={2,4,2},
 		showReward={231},
 	makeResult=0
},
[37] =
{
 		id=37,
 		type=8,
 		level=4,
 		levelCost={702,712,722},
 		costNum={2,4,2},
 		showReward={102},
 	makeResult=0
},
[38] =
{
 		id=38,
 		type=8,
 		level=5,
 		levelCost={703,713,723},
 		costNum={2,4,2},
 		showReward={5},
 	makeResult=0
},
[39] =
{
 		id=39,
 		type=8,
 		level=6,
 		levelCost={704,714,724},
 		costNum={2,2,2},
 		showReward={8502},
 	makeResult=0
},
[40] =
{
 		id=40,
 		type=8,
 		level=7,
 		levelCost={704,714,724},
 		costNum={4,4,4},
 		showReward={251},
 	makeResult=0
},
[41] =
{
 		id=41,
 		type=9,
 		level=1,
 		num=1,
 	makeResult=0
},
[42] =
{
 		id=42,
 		type=9,
 		level=2,
 		num=1,
 		levelCost={701,711,721},
 		costNum={2,2,4},
 	makeResult=0
},
[43] =
{
 		id=43,
 		type=9,
 		level=3,
 		num=1,
 		levelCost={702,712,722},
 		costNum={2,2,4},
 	makeResult=0
},
[44] =
{
 		id=44,
 		type=9,
 		level=4,
 		num=1,
 		levelCost={703,713,723},
 		costNum={2,2,4},
 	makeResult=0
}
}

return {title=title, value=value}