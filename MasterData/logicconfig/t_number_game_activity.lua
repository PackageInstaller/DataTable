-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_number_game_activity.lua

module("logicconfig.config.t_number_game_activity", package.seeall)

local title = {
	rankPlan = 3,
	progressPrizePlan = 5,
	coinItem = 4,
	activityId = 1,
	scorePrizePlan = 2
}
local dataList = {
	{
		54001,
		1,
		1,
		"10:54001",
		0
	},
	{
		54002,
		2,
		1,
		"10:54002",
		0
	},
	{
		54003,
		3,
		1,
		"10:54003",
		1
	},
	{
		54004,
		4,
		1,
		"10:54004",
		2
	},
	{
		54005,
		5,
		1,
		"10:54005",
		3
	},
	{
		54006,
		6,
		1,
		"10:54006",
		4
	},
	{
		54007,
		7,
		1,
		"10:54007",
		5
	},
	{
		54008,
		8,
		1,
		"10:54008",
		6
	},
	{
		54009,
		9,
		1,
		"10:54009",
		7
	},
	{
		54010,
		10,
		2,
		"10:54010",
		8
	},
	{
		54011,
		11,
		1,
		"10:54011",
		9
	},
	{
		54012,
		12,
		2,
		"10:54012",
		9
	},
	{
		54013,
		13,
		1,
		"10:54013",
		10
	},
	{
		54014,
		14,
		1,
		"10:54014",
		11
	},
	{
		54015,
		15,
		1,
		"10:54015",
		12
	}
}
local t_number_game_activity = {
	[54001] = dataList[1],
	[54002] = dataList[2],
	[54003] = dataList[3],
	[54004] = dataList[4],
	[54005] = dataList[5],
	[54006] = dataList[6],
	[54007] = dataList[7],
	[54008] = dataList[8],
	[54009] = dataList[9],
	[54010] = dataList[10],
	[54011] = dataList[11],
	[54012] = dataList[12],
	[54013] = dataList[13],
	[54014] = dataList[14],
	[54015] = dataList[15]
}

t_number_game_activity.dataList = dataList

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

return t_number_game_activity
