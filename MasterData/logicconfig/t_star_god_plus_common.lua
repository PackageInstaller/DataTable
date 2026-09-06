-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_plus_common.lua

module("logicconfig.config.t_star_god_plus_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_LIMIT",
		"999999"
	},
	{
		"MAX_QUANTITY",
		"1000"
	},
	{
		"UPGRADE_COIN_EXP_RATIO",
		"20"
	},
	{
		"UPGRADE_MATERIAL_IDS",
		"501,502,503"
	},
	{
		"UPGRADE_MATERIAL_EXPS",
		"10,50,200"
	},
	{
		"DECOMPOSE_TIPS_QUALITY",
		"3"
	},
	{
		"MAX_STRENGTHEN_LIMIT",
		"300"
	},
	{
		"AUTO_DECOMPOSE_FUN_ID",
		"660"
	},
	{
		"AUTO_DECOMPOSE_DEFAULT_QUALITY",
		"0"
	},
	{
		"UNBIND_RACE_ID_COST",
		"4:907:1"
	}
}
local t_star_god_plus_common = {
	DAILY_LIMIT = dataList[1],
	MAX_QUANTITY = dataList[2],
	UPGRADE_COIN_EXP_RATIO = dataList[3],
	UPGRADE_MATERIAL_IDS = dataList[4],
	UPGRADE_MATERIAL_EXPS = dataList[5],
	DECOMPOSE_TIPS_QUALITY = dataList[6],
	MAX_STRENGTHEN_LIMIT = dataList[7],
	AUTO_DECOMPOSE_FUN_ID = dataList[8],
	AUTO_DECOMPOSE_DEFAULT_QUALITY = dataList[9],
	UNBIND_RACE_ID_COST = dataList[10]
}

t_star_god_plus_common.dataList = dataList

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

return t_star_god_plus_common
