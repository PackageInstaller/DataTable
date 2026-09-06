-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_tian_clg_common.lua

module("logicconfig.config.t_fan_tian_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RACEID",
		"17011"
	},
	{
		"ITEM_CFG",
		"4:382"
	},
	{
		"SHOP_JUMP",
		"mibao#longmaijuexing1"
	},
	{
		"LOTTERY_JUMP",
		"func#965"
	},
	{
		"RANK_JUMP",
		"func#618#17011"
	}
}
local t_fan_tian_clg_common = {
	RACEID = dataList[1],
	ITEM_CFG = dataList[2],
	SHOP_JUMP = dataList[3],
	LOTTERY_JUMP = dataList[4],
	RANK_JUMP = dataList[5]
}

t_fan_tian_clg_common.dataList = dataList

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

return t_fan_tian_clg_common
