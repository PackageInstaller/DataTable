-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rune_common_config.lua

module("logicconfig.config.t_rune_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RUNE_NUMBER_LIMIT",
		"5000"
	},
	{
		"RUNE_MATERIAL_ID",
		"501,502,503"
	},
	{
		"RUNE_MATERIAL_ADD_EXP",
		"10,50,200"
	},
	{
		"UPGRADE_COIN_EXP_RATIO",
		"50"
	},
	{
		"DIAMOND_LEVEL_UP_RATIO",
		"2"
	}
}
local t_rune_common_config = {
	RUNE_NUMBER_LIMIT = dataList[1],
	RUNE_MATERIAL_ID = dataList[2],
	RUNE_MATERIAL_ADD_EXP = dataList[3],
	UPGRADE_COIN_EXP_RATIO = dataList[4],
	DIAMOND_LEVEL_UP_RATIO = dataList[5]
}

t_rune_common_config.dataList = dataList

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

return t_rune_common_config
