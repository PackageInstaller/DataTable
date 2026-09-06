-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_flip_touch_interaction.lua

module("logicconfig.config.t_camp_battle_flip_touch_interaction", package.seeall)

local title = {
	cardNum = 8,
	cost = 6,
	time = 7,
	iconNum2 = 10,
	iconNum1 = 9,
	stageId = 2,
	touchEnergy = 4,
	iconNum5 = 13,
	iconNum4 = 12,
	defaultTime = 5,
	gamePlanId = 1,
	touchNum = 3,
	iconNum3 = 11
}
local dataList = {
	{
		1,
		1,
		1,
		5,
		60,
		"105:160:10",
		30,
		{
			4,
			6
		},
		6,
		6,
		4,
		4,
		4
	},
	{
		2,
		1,
		1,
		5,
		60,
		"105:160:10",
		30,
		{
			4,
			6
		},
		6,
		6,
		4,
		4,
		4
	}
}
local t_camp_battle_flip_touch_interaction = {
	{
		dataList[1]
	},
	{
		dataList[2]
	}
}

t_camp_battle_flip_touch_interaction.dataList = dataList

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

return t_camp_battle_flip_touch_interaction
