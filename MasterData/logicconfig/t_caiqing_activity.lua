-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_caiqing_activity.lua

module("logicconfig.config.t_caiqing_activity", package.seeall)

local title = {
	weekLimit = 5,
	jumpToPlan = 9,
	cost = 3,
	jumpTo = 6,
	drawPlan = 2,
	prize = 4,
	redIdArray = 8,
	jumpToBtn = 7,
	activityId = 1
}
local dataList = {
	{
		242001,
		1,
		"10:242001:10",
		"8:1:100",
		100,
		"",
		nil,
		nil,
		0
	},
	{
		242002,
		2,
		"10:242002:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242002#2",
		nil,
		nil,
		0
	},
	{
		242003,
		3,
		"10:242003:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242003#3",
		nil,
		nil,
		0
	},
	{
		242004,
		4,
		"10:242004:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242004#4",
		nil,
		nil,
		0
	},
	{
		242005,
		5,
		"10:242005:10#10:242006:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242004#4",
		nil,
		nil,
		0
	},
	{
		242006,
		6,
		"10:242007:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242006#5",
		nil,
		nil,
		0
	},
	{
		242007,
		7,
		"10:242009:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242007#6",
		nil,
		nil,
		0
	},
	{
		242008,
		8,
		"10:242010:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242008#7",
		nil,
		nil,
		0
	},
	{
		242009,
		9,
		"10:242011:10",
		"8:1:100",
		160,
		"ui#passporttaskcommonview#242009#8",
		{
			"func#93",
			"ui#rescopyview",
			"func#19",
			"func#9#5",
			"ui#plotcopyview#0",
			"func#5",
			"func#910"
		},
		nil,
		0
	},
	{
		242010,
		10,
		"10:242013:10#10:242012:10",
		"8:1:100",
		300,
		"ui#passporttaskcommonview#242010#9",
		nil,
		nil,
		0
	},
	{
		242011,
		11,
		"10:242014:10",
		"8:1:100",
		80,
		"ui#commongrouptaskmainview#242011",
		{
			"func#690",
			"func#857",
			"func#1102#birthdaywelfaresignpagetourview",
			"func#853",
			"func#1102#summerholidayscheckinmainview",
			"func#908"
		},
		{
			{
				"o36"
			},
			{
				"472"
			},
			{
				"-175"
			},
			{
				"469",
				"470"
			},
			{
				"492"
			},
			{
				"o50"
			}
		},
		0
	},
	{
		242012,
		12,
		"10:242015:10",
		"8:1:100",
		80,
		"ui#commongrouptaskmainview#242012",
		nil,
		nil,
		1
	},
	{
		242013,
		13,
		"10:242016:40",
		"8:1:100",
		80,
		"ui#commongrouptaskmainview#242013",
		nil,
		nil,
		1
	}
}
local t_caiqing_activity = {
	[242001] = dataList[1],
	[242002] = dataList[2],
	[242003] = dataList[3],
	[242004] = dataList[4],
	[242005] = dataList[5],
	[242006] = dataList[6],
	[242007] = dataList[7],
	[242008] = dataList[8],
	[242009] = dataList[9],
	[242010] = dataList[10],
	[242011] = dataList[11],
	[242012] = dataList[12],
	[242013] = dataList[13]
}

t_caiqing_activity.dataList = dataList

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

return t_caiqing_activity
