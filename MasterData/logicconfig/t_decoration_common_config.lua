-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_decoration_common_config.lua

module("logicconfig.config.t_decoration_common_config", package.seeall)

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
		"UPGRADE_COIN_EXP_RATIO",
		"0"
	},
	{
		"COST_DECORATION_EXP_PERCENT",
		"60"
	},
	{
		"UPGRADE_MATERIAL_IDS",
		"31001,31002,31003"
	},
	{
		"UPGRADE_MATERIAL_EXPS",
		"10,50,100"
	},
	{
		"FUNC_OPEN_ID",
		"18"
	},
	{
		"DECOMPOSE_TIPS_QUALITY",
		"5"
	},
	{
		"MAX_ONECLICK_LIMIT",
		"8"
	},
	{
		"MAX_ONECLICK_TIPS",
		"已放入全部可用材料，橙色饰品无法一键放入"
	},
	{
		"STRENGTHEN_QUALITY_PLAN",
		"0"
	},
	{
		"RECYCLE_QUALITY_PLAN",
		"0"
	}
}
local t_decoration_common_config = {
	DAILY_LIMIT = dataList[1],
	MAX_QUANTITY = dataList[2],
	UPGRADE_COIN_EXP_RATIO = dataList[3],
	COST_DECORATION_EXP_PERCENT = dataList[4],
	UPGRADE_MATERIAL_IDS = dataList[5],
	UPGRADE_MATERIAL_EXPS = dataList[6],
	FUNC_OPEN_ID = dataList[7],
	DECOMPOSE_TIPS_QUALITY = dataList[8],
	MAX_ONECLICK_LIMIT = dataList[9],
	MAX_ONECLICK_TIPS = dataList[10],
	STRENGTHEN_QUALITY_PLAN = dataList[11],
	RECYCLE_QUALITY_PLAN = dataList[12]
}

t_decoration_common_config.dataList = dataList

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

return t_decoration_common_config
