-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_dark_dragon_common.lua

module("logicconfig.config.t_light_dark_dragon_common", package.seeall)

local title = {
	parameter = 1,
	value = 2
}
local dataList = {
	{
		"Level1",
		"4:384:2000"
	},
	{
		"Level2",
		"4:384:2800"
	},
	{
		"Level3",
		"4:384:1500"
	},
	{
		"OPEN_RULE",
		"skslmainview_rule"
	},
	{
		"OPEN_RULE_LIMIT",
		"imperialDragon_SyVictoria_rule"
	},
	{
		"ACT_TIME",
		"活动时间：05.10 5:00 - 05.31 5:00"
	}
}
local t_light_dark_dragon_common = {
	Level1 = dataList[1],
	Level2 = dataList[2],
	Level3 = dataList[3],
	OPEN_RULE = dataList[4],
	OPEN_RULE_LIMIT = dataList[5],
	ACT_TIME = dataList[6]
}

t_light_dark_dragon_common.dataList = dataList

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

return t_light_dark_dragon_common
