-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_dark_tower_limit_condition.lua

module("logicconfig.config.t_water_dark_tower_limit_condition", package.seeall)

local title = {
	conditionPlanId = 1,
	towerType = 2,
	towerRace = 3,
	filter = 4
}
local dataList = {
	{
		1,
		1,
		"水",
		"RaceType$水"
	},
	{
		1,
		2,
		"暗",
		"RaceType$暗"
	},
	{
		2,
		1,
		"水,光",
		"RaceType$水|RaceType$光"
	}
}
local t_water_dark_tower_limit_condition = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3]
	}
}

t_water_dark_tower_limit_condition.dataList = dataList

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

return t_water_dark_tower_limit_condition
