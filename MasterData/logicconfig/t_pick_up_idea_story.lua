-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pick_up_idea_story.lua

module("logicconfig.config.t_pick_up_idea_story", package.seeall)

local title = {
	id = 2,
	storyId = 6,
	progress = 4,
	index = 3,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		338001,
		1,
		1,
		50,
		"原初神女提着马头琴一个箭步越上舞台，其充满野性风情的打扮和矫健的身手令众人眼前一亮。台下人山人海，可原初神女毫不怯场……",
		4600009
	},
	{
		338001,
		1,
		2,
		100,
		"原初神女目光如炬，下一刻马头琴声起，婉转的音符顿时揪住了所有人的心。然而音调一转，琴声复而变得慷慨激昂……",
		4600010
	},
	{
		338001,
		2,
		1,
		50,
		"幕后，原初抱着白猫便见到了这样一幕：希望神女在休息室等待侍女们的梳妆打扮，然而她神色落寞，看起来有些失望。",
		4600013
	},
	{
		338001,
		2,
		2,
		100,
		"希望神女一曲终了，舞姿活泼，乐声优美，全场哑然，人们都沉浸在公主殿下的压轴演出中，过了半晌才反应过来，热烈的掌声经久不息。",
		4600014
	},
	{
		338001,
		3,
		1,
		50,
		"龙尊圣女怀抱琵琶上台，众人皆被她雍容华贵的身姿吸引住了。她稍稍伫立片刻，浮现在她脑海中的，是儿时那些刻苦练习的时光……",
		4600007
	},
	{
		338001,
		3,
		2,
		100,
		"帷幕之后，少女身着银饰只见正理抱着一只小狼瑟瑟发抖，时不时打量着场外，嘴里不停地念叨着什么，正是之前开场表演的正理。",
		4600008
	},
	{
		338001,
		4,
		1,
		50,
		"银饰清响，正理手持夜箫轻快地跳上了舞台，一只憨态可掬的小狼崽紧跟着她，一人一狼的可爱模样让观众们忍俊不禁。",
		4600011
	},
	{
		338001,
		4,
		2,
		100,
		"正理抱着旺财蹑手蹑脚地踱进后台，准备找个角落蹲着，避人耳目，没想到一向乖巧的旺财此刻却十分暴躁。",
		4600012
	}
}
local t_pick_up_idea_story = {
	[338001] = {
		{
			dataList[1],
			dataList[2]
		},
		{
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8]
		}
	}
}

t_pick_up_idea_story.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_pick_up_idea_story
