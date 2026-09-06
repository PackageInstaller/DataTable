-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_equipment_other_config.lua

module("logicconfig.config.t_star_equipment_other_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"UPGRADE_MATERIAL_ITEM_ID",
		"54"
	},
	{
		"UPGRADE_MATERIAL_ITEM_EXP",
		"100"
	},
	{
		"UPGRADE_COIN_EXP_RATIO",
		"1"
	}
}
local t_star_equipment_other_config = {
	UPGRADE_MATERIAL_ITEM_ID = dataList[1],
	UPGRADE_MATERIAL_ITEM_EXP = dataList[2],
	UPGRADE_COIN_EXP_RATIO = dataList[3]
}

t_star_equipment_other_config.dataList = dataList

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

return t_star_equipment_other_config
