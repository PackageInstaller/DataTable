-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_extreme_pass.lua

module("logicconfig.config.t_divine_invincible_extreme_pass", package.seeall)

local title = {
	validator = 3,
	groupAttackTimes = 4,
	posId = 2,
	extremePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"OriginalRaceType$草",
		3
	},
	{
		1,
		2,
		"OriginalRaceType$水",
		4
	},
	{
		1,
		3,
		"OriginalRaceType$火",
		3
	},
	{
		1,
		4,
		"OriginalRaceType$光",
		4
	},
	{
		1,
		5,
		"OriginalRaceType$暗",
		3
	},
	{
		1,
		6,
		"OriginalRaceType$空",
		4
	},
	{
		1,
		7,
		"OriginalRaceType$创",
		3
	},
	{
		1,
		8,
		"OriginalRaceType$火",
		4
	},
	{
		1,
		9,
		"OriginalRaceType$草",
		3
	},
	{
		2,
		1,
		"OriginalRaceType$草",
		1
	},
	{
		2,
		2,
		"OriginalRaceType$水",
		1
	},
	{
		2,
		3,
		"OriginalRaceType$火",
		1
	},
	{
		2,
		4,
		"OriginalRaceType$光",
		1
	},
	{
		2,
		5,
		"OriginalRaceType$暗",
		1
	},
	{
		2,
		6,
		"OriginalRaceType$空",
		1
	},
	{
		2,
		7,
		"OriginalRaceType$创",
		1
	},
	{
		2,
		8,
		"OriginalRaceType$火",
		1
	},
	{
		2,
		9,
		"OriginalRaceType$草",
		1
	}
}
local t_divine_invincible_extreme_pass = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_divine_invincible_extreme_pass.dataList = dataList

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

return t_divine_invincible_extreme_pass
