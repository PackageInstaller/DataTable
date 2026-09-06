-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_step.lua

module("logicconfig.config.t_abyss_gold_rush_step", package.seeall)

local title = {
	stepType = 4,
	handleType = 5,
	roundId = 3,
	dropRound = 7,
	stepId = 2,
	petBoxRound = 6,
	activityId = 1
}
local dataList = {
	{
		612001,
		1,
		1,
		0,
		"openPetBox",
		1,
		0
	},
	{
		612001,
		2,
		1,
		0,
		"petSelect",
		1,
		0
	},
	{
		612001,
		3,
		1,
		0,
		"battle",
		0,
		0
	},
	{
		612001,
		4,
		1,
		1,
		"holyStripeDrop",
		0,
		1
	},
	{
		612001,
		5,
		1,
		1,
		"openPetBox",
		2,
		0
	},
	{
		612001,
		6,
		1,
		1,
		"petSelect",
		2,
		0
	},
	{
		612001,
		7,
		1,
		0,
		"nextRound",
		0,
		0
	},
	{
		612001,
		8,
		2,
		2,
		"holyStripeDrop",
		0,
		1
	},
	{
		612001,
		9,
		2,
		2,
		"openPetBox",
		2,
		0
	},
	{
		612001,
		10,
		2,
		2,
		"petSelect",
		2,
		0
	},
	{
		612001,
		11,
		2,
		0,
		"battle",
		0,
		0
	},
	{
		612001,
		12,
		2,
		1,
		"holyStripeDrop",
		0,
		2
	},
	{
		612001,
		13,
		2,
		1,
		"openPetBox",
		3,
		0
	},
	{
		612001,
		14,
		2,
		1,
		"petSelect",
		3,
		0
	},
	{
		612001,
		15,
		2,
		0,
		"nextRound",
		0,
		0
	},
	{
		612001,
		16,
		3,
		2,
		"holyStripeDrop",
		0,
		2
	},
	{
		612001,
		17,
		3,
		2,
		"openPetBox",
		3,
		0
	},
	{
		612001,
		18,
		3,
		2,
		"petSelect",
		3,
		0
	},
	{
		612001,
		19,
		3,
		0,
		"battle",
		0,
		0
	},
	{
		612001,
		20,
		3,
		1,
		"holyStripeDrop",
		0,
		3
	}
}
local t_abyss_gold_rush_step = {
	[612001] = {
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

t_abyss_gold_rush_step.dataList = dataList

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

return t_abyss_gold_rush_step
