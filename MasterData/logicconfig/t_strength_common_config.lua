-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_strength_common_config.lua

module("logicconfig.config.t_strength_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CLICK_SUPPLY",
		"无论多么忙碌，也不要忘了准时用餐哦！"
	},
	{
		"DAILY_FREE_COMPENSTAE_CONSUME",
		"20"
	},
	{
		"DAILY_FREE_STRENGTH",
		"120"
	},
	{
		"FREE_STRENGTH_TIME_PLAN_ID",
		"85"
	},
	{
		"FREE_STRENGTH_REPLACE",
		"240"
	},
	{
		"FREE_STRENGTH_MAX_LIMIT",
		"720"
	},
	{
		"STRENGTH_TIMES_DESC",
		"限时翻倍"
	},
	{
		"STRENGTH_LIMIT",
		"360"
	},
	{
		"STRENGTH_RECOVERY_EFFICIENCY",
		"240"
	},
	{
		"BUY_STRENGTH_LIMIT",
		"20"
	},
	{
		"BUY_STRENGTH_GET_NUMBER",
		"120"
	},
	{
		"BUY_STRENGTH_CONSUME",
		"50"
	},
	{
		"STRENGTH_RECOVERY_NUM",
		"30#60#120"
	}
}
local t_strength_common_config = {
	CLICK_SUPPLY = dataList[1],
	DAILY_FREE_COMPENSTAE_CONSUME = dataList[2],
	DAILY_FREE_STRENGTH = dataList[3],
	FREE_STRENGTH_TIME_PLAN_ID = dataList[4],
	FREE_STRENGTH_REPLACE = dataList[5],
	FREE_STRENGTH_MAX_LIMIT = dataList[6],
	STRENGTH_TIMES_DESC = dataList[7],
	STRENGTH_LIMIT = dataList[8],
	STRENGTH_RECOVERY_EFFICIENCY = dataList[9],
	BUY_STRENGTH_LIMIT = dataList[10],
	BUY_STRENGTH_GET_NUMBER = dataList[11],
	BUY_STRENGTH_CONSUME = dataList[12],
	STRENGTH_RECOVERY_NUM = dataList[13]
}

t_strength_common_config.dataList = dataList

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

return t_strength_common_config
