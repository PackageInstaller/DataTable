-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_manual_common_config.lua

module("logicconfig.config.t_pet_manual_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"PREVIEW_BTL_FIGHT_MONSTER_ID",
		"3001"
	},
	{
		"PREVIEW_BTL_PET_LEVEL",
		"100"
	},
	{
		"PREVIEW_BTL_PET_POS",
		"5"
	},
	{
		"PREVIEW_BTL_PET_TALENT_LEVEL",
		"10"
	},
	{
		"MAX_POWER_DISCOUNT",
		"0.3"
	},
	{
		"WAN_PERCENT_UP",
		"4000"
	}
}
local t_pet_manual_common_config = {
	PREVIEW_BTL_FIGHT_MONSTER_ID = dataList[1],
	PREVIEW_BTL_PET_LEVEL = dataList[2],
	PREVIEW_BTL_PET_POS = dataList[3],
	PREVIEW_BTL_PET_TALENT_LEVEL = dataList[4],
	MAX_POWER_DISCOUNT = dataList[5],
	WAN_PERCENT_UP = dataList[6]
}

t_pet_manual_common_config.dataList = dataList

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

return t_pet_manual_common_config
