-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_bounty_common_vars.lua

module("logicconfig.config.t_divine_bounty_common_vars", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BIG_PRIZE_ID",
		"1#5"
	},
	{
		"LOTTERY_COST",
		"204:22000939:6"
	},
	{
		"LOTTERY_TEN_DISCOUNT_COST",
		"204:22000939:20"
	},
	{
		"DISCOUNT_TIMES",
		"1"
	},
	{
		"SHOPPAY_COST",
		"204:22000939#8:43"
	},
	{
		"LOTTERY_BASE_PRIZE",
		"8:1:500"
	},
	{
		"TAB_NAME",
		"神曜材料#源起材料"
	}
}
local t_divine_bounty_common_vars = {
	BIG_PRIZE_ID = dataList[1],
	LOTTERY_COST = dataList[2],
	LOTTERY_TEN_DISCOUNT_COST = dataList[3],
	DISCOUNT_TIMES = dataList[4],
	SHOPPAY_COST = dataList[5],
	LOTTERY_BASE_PRIZE = dataList[6],
	TAB_NAME = dataList[7]
}

t_divine_bounty_common_vars.dataList = dataList

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

return t_divine_bounty_common_vars
