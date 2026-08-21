local title = {
	id = 0,
	hero = 0,
	stage = 0,
	feelingLevel = 0,
	feelingValue = 0,
	title = 0,
	unlockName = {},
	unlockWords = {},
	linkTo = {},
	type = {},
	roomStory = 0,
	upLevel = 0,
	heroStory = 0,
	giftWords = {},
	roomEvent = 0
}

local value = {
[11000300] =
{
 		id=11000300,
 		hero=110003,
 		stage=1,
 		unlockName={586},
 		giftWords={10001},
 	roomEvent=1013
},
[11000301] =
{
 		id=11000301,
 		hero=110003,
 		stage=1,
 		feelingLevel=1,
 		feelingValue=120,
 		title=7001,
 		unlockName={567},
 		unlockWords={7101},
 		linkTo={5},
 		type={5},
 		roomStory=105,
 		giftWords={10001,10002},
 	roomEvent=0
},
[11000302] =
{
 		id=11000302,
 		hero=110003,
 		stage=1,
 		feelingLevel=2,
 		feelingValue=320,
 		title=7002,
 		unlockName={568},
 		unlockWords={7102,7115},
 		linkTo={0},
 		giftWords={10001,10002},
 	roomEvent=1015
},
[11000303] =
{
 		id=11000303,
 		hero=110003,
 		stage=1,
 		feelingLevel=3,
 		feelingValue=520,
 		title=7003,
 		unlockName={569},
 		unlockWords={7120,7103,7113},
 		linkTo={5,0,0},
 		type={5,3},
 		roomStory=101,
 		giftWords={10001,10002,10003},
 	roomEvent=0
},
[11000304] =
{
 		id=11000304,
 		hero=110003,
 		stage=2,
 		feelingLevel=4,
 		feelingValue=840,
 		title=7004,
 		unlockName={570},
 		unlockWords={7104},
 		linkTo={5,0},
 		type={5},
 		roomStory=102,
 		giftWords={10001,10002,10003},
 	roomEvent=0
},
[11000305] =
{
 		id=11000305,
 		hero=110003,
 		stage=2,
 		feelingLevel=5,
 		feelingValue=1160,
 		title=7005,
 		unlockName={571},
 		unlockWords={7105,7115},
 		linkTo={0},
 		giftWords={10001,10002,10003},
 	roomEvent=1017
},
[11000306] =
{
 		id=11000306,
 		hero=110003,
 		stage=2,
 		feelingLevel=6,
 		feelingValue=1580,
 		title=7006,
 		unlockName={572},
 		unlockWords={7106,7114},
 		linkTo={0},
 		type={3},
 		giftWords={10001,10002,10003,10004},
 	roomEvent=0
},
[11000307] =
{
 		id=11000307,
 		hero=110003,
 		stage=3,
 		feelingLevel=7,
 		feelingValue=2000,
 		title=7007,
 		unlockName={573},
 		unlockWords={7107},
 		linkTo={5},
 		type={5},
 		roomStory=104,
 		giftWords={10001,10002,10003,10004},
 	roomEvent=0
},
[11000308] =
{
 		id=11000308,
 		hero=110003,
 		stage=3,
 		feelingLevel=8,
 		feelingValue=2600,
 		title=7008,
 		unlockName={574},
 		unlockWords={7108,7115},
 		linkTo={0},
 		giftWords={10001,10002,10003,10004},
 	roomEvent=1019
},
[11000309] =
{
 		id=11000309,
 		hero=110003,
 		stage=3,
 		feelingLevel=9,
 		feelingValue=3200,
 		title=7009,
 		unlockName={575},
 		unlockWords={7109},
 		linkTo={0},
 		type={3},
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=0
},
[11000310] =
{
 		id=11000310,
 		hero=110003,
 		stage=4,
 		feelingLevel=10,
 		feelingValue=3900,
 		title=7010,
 		unlockName={576},
 		unlockWords={7110},
 		linkTo={5,0},
 		type={5},
 		roomStory=106,
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=0
},
[11000311] =
{
 		id=11000311,
 		hero=110003,
 		stage=4,
 		feelingLevel=11,
 		feelingValue=4600,
 		title=7011,
 		unlockName={577},
 		unlockWords={7111,7115},
 		linkTo={0},
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=1021
},
[11000312] =
{
 		id=11000312,
 		hero=110003,
 		stage=4,
 		feelingLevel=12,
 		feelingValue=6000,
 		title=7012,
 		unlockName={578},
 		unlockWords={7121,7112},
 		linkTo={5,0,0},
 		type={5,4},
 		roomStory=107,
 		upLevel=10,
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=0
},
[12000100] =
{
 		id=12000100,
 		hero=120001,
 		stage=1,
 		unlockName={586},
 		giftWords={10001},
 	roomEvent=1013
},
[12000101] =
{
 		id=12000101,
 		hero=120001,
 		stage=1,
 		feelingLevel=1,
 		feelingValue=120,
 		title=7001,
 		unlockName={567},
 		unlockWords={7101},
 		linkTo={5},
 		type={5},
 		roomStory=105,
 		giftWords={10001,10002},
 	roomEvent=0
},
[12000102] =
{
 		id=12000102,
 		hero=120001,
 		stage=1,
 		feelingLevel=2,
 		feelingValue=320,
 		title=7002,
 		unlockName={568},
 		unlockWords={7102,7115},
 		linkTo={0},
 		giftWords={10001,10002},
 	roomEvent=1015
},
[12000103] =
{
 		id=12000103,
 		hero=120001,
 		stage=1,
 		feelingLevel=3,
 		feelingValue=520,
 		title=7003,
 		unlockName={569},
 		unlockWords={7120,7103,7113},
 		linkTo={5,0,0},
 		type={5,3},
 		roomStory=101,
 		giftWords={10001,10002,10003},
 	roomEvent=0
},
[12000104] =
{
 		id=12000104,
 		hero=120001,
 		stage=2,
 		feelingLevel=4,
 		feelingValue=840,
 		title=7004,
 		unlockName={570},
 		unlockWords={7104,7115},
 		linkTo={5,0},
 		type={5},
 		roomStory=102,
 		giftWords={10001,10002,10003},
 	roomEvent=0
},
[12000105] =
{
 		id=12000105,
 		hero=120001,
 		stage=2,
 		feelingLevel=5,
 		feelingValue=1160,
 		title=7005,
 		unlockName={571},
 		unlockWords={7105,7115},
 		linkTo={0},
 		giftWords={10001,10002,10003},
 	roomEvent=1017
},
[12000106] =
{
 		id=12000106,
 		hero=120001,
 		stage=2,
 		feelingLevel=6,
 		feelingValue=1580,
 		title=7006,
 		unlockName={572},
 		unlockWords={7106,7114},
 		linkTo={0},
 		type={3},
 		giftWords={10001,10002,10003,10004},
 	roomEvent=0
},
[12000107] =
{
 		id=12000107,
 		hero=120001,
 		stage=3,
 		feelingLevel=7,
 		feelingValue=2000,
 		title=7007,
 		unlockName={573},
 		unlockWords={7107},
 		linkTo={5},
 		type={5},
 		roomStory=104,
 		giftWords={10001,10002,10003,10004},
 	roomEvent=0
},
[12000108] =
{
 		id=12000108,
 		hero=120001,
 		stage=3,
 		feelingLevel=8,
 		feelingValue=2600,
 		title=7008,
 		unlockName={574},
 		unlockWords={7108,7115},
 		linkTo={0},
 		giftWords={10001,10002,10003,10004},
 	roomEvent=1019
},
[12000109] =
{
 		id=12000109,
 		hero=120001,
 		stage=3,
 		feelingLevel=9,
 		feelingValue=3200,
 		title=7009,
 		unlockName={575},
 		unlockWords={7109},
 		linkTo={0},
 		type={3},
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=0
},
[12000110] =
{
 		id=12000110,
 		hero=120001,
 		stage=4,
 		feelingLevel=10,
 		feelingValue=3900,
 		title=7010,
 		unlockName={576},
 		unlockWords={7110,7115},
 		linkTo={5,0},
 		type={5},
 		roomStory=106,
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=0
},
[12000111] =
{
 		id=12000111,
 		hero=120001,
 		stage=4,
 		feelingLevel=11,
 		feelingValue=4600,
 		title=7011,
 		unlockName={577},
 		unlockWords={7111,7115},
 		linkTo={0},
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=1021
},
[12000112] =
{
 		id=12000112,
 		hero=120001,
 		stage=4,
 		feelingLevel=12,
 		feelingValue=6000,
 		title=7012,
 		unlockName={578},
 		unlockWords={7121,7112},
 		linkTo={5,0,0},
 		type={5,4},
 		roomStory=107,
 		upLevel=10,
 		giftWords={10001,10002,10003,10004,10005},
 	roomEvent=0
}
}

return {title=title, value=value}