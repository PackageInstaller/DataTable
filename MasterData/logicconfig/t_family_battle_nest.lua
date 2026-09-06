-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_battle_nest.lua

module("logicconfig.config.t_family_battle_nest", package.seeall)

local title = {
	nestMonsterPlanId = 3,
	name = 7,
	prize_client = 5,
	nestId = 2,
	nestConditionPlanId = 6,
	icon = 8,
	energy = 4,
	nestPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		50,
		"8:5:200#8:27:100#104:2:50#4:10000046:50",
		1,
		"幽冥古堡",
		"icon_map_jz02"
	},
	{
		1,
		2,
		2,
		50,
		"8:5:200#8:27:100#104:2:50#4:10000046:50",
		2,
		"森林寺庙",
		"icon_map_jz01"
	},
	{
		1,
		3,
		3,
		50,
		"8:5:200#8:27:100#104:2:50#4:10000046:50",
		3,
		"幽灵船",
		"icon_map_jz04"
	},
	{
		1,
		4,
		4,
		50,
		"8:5:200#8:27:100#104:2:50#4:10000046:50",
		4,
		"火山巢穴",
		"icon_map_jz03"
	}
}
local t_family_battle_nest = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_family_battle_nest.dataList = dataList

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

return t_family_battle_nest
