-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_revive_elizabeth_world_progress_prize.lua

module("logicconfig.config.t_revive_elizabeth_world_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	storyId = 5,
	progress = 3,
	activityId = 1
}
local dataList = {
	{
		416001,
		1,
		500,
		"4:31:3",
		0
	},
	{
		416001,
		2,
		1000,
		"4:111:2",
		0
	},
	{
		416001,
		3,
		2000,
		"4:31:3",
		0
	},
	{
		416001,
		4,
		4000,
		"4:111:2",
		0
	},
	{
		416001,
		5,
		6000,
		"4:31:3",
		0
	},
	{
		416001,
		6,
		8000,
		"4:111:2",
		4720002
	},
	{
		416001,
		7,
		10000,
		"4:31:3",
		0
	},
	{
		416001,
		8,
		12500,
		"4:111:2",
		0
	},
	{
		416001,
		9,
		15000,
		"4:31:3",
		0
	},
	{
		416001,
		10,
		17500,
		"4:111:2",
		0
	},
	{
		416001,
		11,
		20000,
		"4:31:3",
		0
	},
	{
		416001,
		12,
		25000,
		"4:111:2",
		4720003
	},
	{
		416001,
		13,
		30000,
		"4:31:3",
		0
	},
	{
		416001,
		14,
		35000,
		"4:111:2",
		0
	},
	{
		416001,
		15,
		40000,
		"4:31:3",
		0
	},
	{
		416001,
		16,
		45000,
		"4:111:2",
		0
	},
	{
		416001,
		17,
		50000,
		"4:31:3",
		0
	},
	{
		416001,
		18,
		60000,
		"4:111:2",
		0
	},
	{
		416001,
		19,
		70000,
		"4:31:3",
		0
	},
	{
		416001,
		20,
		80000,
		"4:111:2",
		4720004
	}
}
local t_revive_elizabeth_world_progress_prize = {
	[416001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_revive_elizabeth_world_progress_prize.dataList = dataList

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

return t_revive_elizabeth_world_progress_prize
