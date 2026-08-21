local title = {
	id = 0,
	heroId = 0,
	beginTime = 0,
	endTime = 0,
	eventId = {},
	power = {},
	eventTimes = 0
}

local value = {
[1] =
{
 		id=1,
 		heroId=110003,
 		endTime=21600,
 		eventId={4},
 		power={100},
 	eventTimes=99
},
[2] =
{
 		id=2,
 		heroId=110003,
 		beginTime=21600,
 		endTime=72000,
 		eventId={4,5,6,7,9},
 		power={10,100,100,100,100},
 	eventTimes=99
},
[3] =
{
 		id=3,
 		heroId=110003,
 		beginTime=72000,
 		endTime=79200,
 		eventId={4,3,5,6,9},
 		power={100,100,100,100,100},
 	eventTimes=99
},
[4] =
{
 		id=4,
 		heroId=110003,
 		beginTime=79200,
 		endTime=86400,
 		eventId={4,5,6,9},
 		power={10000,100,100,100},
 	eventTimes=99
},
[5] =
{
 		id=5,
 		heroId=120001,
 		endTime=21600,
 		eventId={4},
 		power={100},
 	eventTimes=99
},
[6] =
{
 		id=6,
 		heroId=120001,
 		beginTime=21600,
 		endTime=72000,
 		eventId={4,5,6,7,9},
 		power={10,100,100,100,100},
 	eventTimes=99
},
[7] =
{
 		id=7,
 		heroId=120001,
 		beginTime=72000,
 		endTime=79200,
 		eventId={4,3,5,6,9},
 		power={100,100,100,100,100},
 	eventTimes=99
},
[8] =
{
 		id=8,
 		heroId=120001,
 		beginTime=79200,
 		endTime=86400,
 		eventId={4,5,6,9},
 		power={10000,100,100,100},
 	eventTimes=99
}
}

return {title=title, value=value}