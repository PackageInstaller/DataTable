-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_longyan_challenge_skill_strategy.lua

module("logicconfig.config.t_divine_longyan_challenge_skill_strategy", package.seeall)

local title = {
	cost = 5,
	petLevelLimit = 4,
	skillType = 2,
	activityId = 1,
	skillLevel = 3
}
local dataList = {
	{
		355001,
		1,
		1,
		0,
		0
	},
	{
		355001,
		1,
		2,
		30,
		20
	},
	{
		355001,
		1,
		3,
		60,
		35
	},
	{
		355001,
		1,
		4,
		80,
		45
	},
	{
		355001,
		1,
		5,
		100,
		60
	},
	{
		355001,
		2,
		1,
		0,
		0
	},
	{
		355001,
		2,
		2,
		30,
		20
	},
	{
		355001,
		2,
		3,
		60,
		35
	},
	{
		355001,
		2,
		4,
		80,
		45
	},
	{
		355001,
		2,
		5,
		100,
		60
	},
	{
		355001,
		3,
		1,
		0,
		0
	},
	{
		355001,
		3,
		2,
		30,
		20
	},
	{
		355001,
		3,
		3,
		60,
		35
	},
	{
		355001,
		3,
		4,
		80,
		45
	},
	{
		355001,
		3,
		5,
		100,
		60
	}
}
local t_divine_longyan_challenge_skill_strategy = {
	[355001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_divine_longyan_challenge_skill_strategy.dataList = dataList

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

return t_divine_longyan_challenge_skill_strategy
