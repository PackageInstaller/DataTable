local title = {
	id = 0,
	type = 0,
	eventType = 0,
	openCondition = 0,
	showType = 0,
	pushTime = 0,
	favorValue = 0,
	desc = 0,
	lastTime = 0,
	voice = 0,
	voiceTimes = 0,
	timeline = 0,
	actionName = "",
	actionEvents = 0,
	position = "",
	roomStory = {},
	triggerType = 0,
	count = 0
}

local value = {
[1] =
{
 		id=1,
 		type=2,
 		eventType=2,
 		showType=2,
 		pushTime=3,
 		favorValue=10,
 		desc=2004,
 		lastTime=600,
 		actionName="Anxixiang_WatchPoint_ShowStandingReading",
 		position="Bookcase",
 		roomStory={1503},
 		triggerType=2,
 	count=1
},
[2] =
{
 		id=2,
 		type=2,
 		eventType=3,
 		showType=3,
 		pushTime=15,
 		favorValue=10,
 		lastTime=600,
 		actionName="Anxixiang_WatchPoint_ShowSofaComfort",
 		position="Sofa",
 		roomStory={1006},
 		triggerType=1,
 	count=1
},
[3] =
{
 		id=3,
 		type=1,
 		eventType=4,
 		openCondition=10002,
 		showType=2,
 		pushTime=3,
 		favorValue=10,
 		desc=5133,
 		lastTime=600,
 		timeline=11000303,
 		triggerType=2,
 	count=1
},
[4] =
{
 		id=4,
 		type=3,
 		actionEvents=100,
 		position="Bed",
 		triggerType=2,
 	count=0
},
[5] =
{
 		id=5,
 		type=3,
 		actionEvents=105,
 		position="Photowall3",
 		triggerType=2,
 	count=0
},
[6] =
{
 		id=6,
 		type=1,
 		openCondition=8006,
 		timeline=11000305,
 		position="Main",
 		triggerType=2,
 	count=1
},
[7] =
{
 		id=7,
 		type=3,
 		actionEvents=101,
 		position="Console",
 		triggerType=2,
 	count=0
},
[8] =
{
 		id=8,
 		type=3,
 		actionEvents=103,
 		position="Bookcase",
 		triggerType=2,
 	count=0
},
[9] =
{
 		id=9,
 		type=3,
 		actionEvents=102,
 		position="Sofa",
 		triggerType=2,
 	count=0
},
[10] =
{
 		id=10,
 		type=2,
 		eventType=2,
 		showType=2,
 		pushTime=3,
 		favorValue=10,
 		desc=2004,
 		lastTime=600,
 		actionName="Anxixiang_WatchPoint_ShowStandingReading",
 		position="Bookcase",
 		triggerType=2,
 	count=1
}
}

return {title=title, value=value}