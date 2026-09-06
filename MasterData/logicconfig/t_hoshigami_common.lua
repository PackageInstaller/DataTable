-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hoshigami_common.lua

module("logicconfig.config.t_hoshigami_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_LIMIT",
		"800"
	},
	{
		"MAX_QUANTITY",
		"800"
	},
	{
		"UPGRADE_ITEM_ID",
		"901"
	},
	{
		"REFUND_RATIO",
		"1"
	},
	{
		"PREFAB_SUIT_MAX_QUANITY",
		"20"
	}
}
local t_hoshigami_common = {
	DAILY_LIMIT = dataList[1],
	MAX_QUANTITY = dataList[2],
	UPGRADE_ITEM_ID = dataList[3],
	REFUND_RATIO = dataList[4],
	PREFAB_SUIT_MAX_QUANITY = dataList[5]
}

t_hoshigami_common.dataList = dataList

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

return t_hoshigami_common
