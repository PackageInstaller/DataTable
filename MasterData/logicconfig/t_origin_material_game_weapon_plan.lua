-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_material_game_weapon_plan.lua

module("logicconfig.config.t_origin_material_game_weapon_plan", package.seeall)

local title = {
	weaponPlanId = 1,
	weaponIdList = 2
}
local dataList = {
	{
		1,
		{
			11,
			12,
			13,
			14,
			15,
			3
		}
	},
	{
		2,
		{
			11,
			12,
			13,
			14,
			15,
			3,
			17
		}
	}
}
local t_origin_material_game_weapon_plan = {
	dataList[1],
	dataList[2]
}

t_origin_material_game_weapon_plan.dataList = dataList

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

return t_origin_material_game_weapon_plan
