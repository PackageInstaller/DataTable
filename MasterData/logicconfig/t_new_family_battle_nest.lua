-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_battle_nest.lua

module("logicconfig.config.t_new_family_battle_nest", package.seeall)

local title = {
	damageScorePlan = 4,
	name = 5,
	nestId = 2,
	creepsMasterId = 3,
	icon = 6,
	pos = 7,
	nestPlanId = 1
}
local dataList = {
	{
		1,
		1,
		200001,
		1,
		"幽灵船",
		"ui/icon/task/icon_map_jz04",
		{
			-35,
			9,
			1
		}
	}
}
local t_new_family_battle_nest = {
	{
		dataList[1]
	}
}

t_new_family_battle_nest.dataList = dataList

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

return t_new_family_battle_nest
