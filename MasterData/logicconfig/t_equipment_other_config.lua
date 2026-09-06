-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_equipment_other_config.lua

module("logicconfig.config.t_equipment_other_config", package.seeall)

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
		"1500"
	},
	{
		"UPGRADE_MATERIAL_IDS",
		"30000,30001,30002,30003"
	},
	{
		"UPGRADE_MATERIAL_EXPS",
		"5,50,200,500"
	},
	{
		"DECOMPOSE_TIPS_QUALITY",
		"5"
	},
	{
		"MAX_STRENGTHEN_LIMIT",
		"300"
	},
	{
		"MAX_ONECLICK_LIMIT",
		"8"
	},
	{
		"MAX_ONECLICK_TIPS",
		"已放入全部可用材料，橙色装备无法一键放入"
	},
	{
		"MANY_MERGE_ONE",
		"4"
	},
	{
		"ATTRI_PROBABILITY",
		"25"
	},
	{
		"MAX_ATTRI_STONE",
		"1"
	},
	{
		"STRENGTHEN_QUALITY_PLAN",
		"2"
	},
	{
		"RECYCLE_QUALITY_PLAN",
		"2"
	},
	{
		"EXCLUSIVE_UPGRADE_MATERIAL_IDS",
		"906,904,905,903"
	},
	{
		"EXCLUSIVE_UPGRADE_MATERIAL_EXPS",
		"50,50,50,50"
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
		"BREAKOUT_ORANGE_TWO_PLAYER_LV",
		"36"
	},
	{
		"ORANGE_TWO_STONE_COUNT",
		"4:7008:100,4:7008:100,4:7008:100,4:7008:100"
	},
	{
		"ORANGE_TWO_MATERIAL_EQUIPMENT_COUNT",
		"2"
	},
	{
		"MATERIAL_CAPACITY_PET_START_LINE",
		"50"
	},
	{
		"MATERIAL_CAPACITY_INCR_PET_GAP",
		"10"
	},
	{
		"MATERIAL_CAPACITY_GAP_ADD_PERCENT",
		"5"
	},
	{
		"MATERIAL_CAPACITY_MAX_VALUE",
		"3000"
	},
	{
		"MAX_BATCH_BREAKOUT_COUNT",
		"20"
	}
}
local t_equipment_other_config = {
	DAILY_LIMIT = dataList[1],
	MAX_QUANTITY = dataList[2],
	UPGRADE_MATERIAL_IDS = dataList[3],
	UPGRADE_MATERIAL_EXPS = dataList[4],
	DECOMPOSE_TIPS_QUALITY = dataList[5],
	MAX_STRENGTHEN_LIMIT = dataList[6],
	MAX_ONECLICK_LIMIT = dataList[7],
	MAX_ONECLICK_TIPS = dataList[8],
	MANY_MERGE_ONE = dataList[9],
	ATTRI_PROBABILITY = dataList[10],
	MAX_ATTRI_STONE = dataList[11],
	STRENGTHEN_QUALITY_PLAN = dataList[12],
	RECYCLE_QUALITY_PLAN = dataList[13],
	EXCLUSIVE_UPGRADE_MATERIAL_IDS = dataList[14],
	EXCLUSIVE_UPGRADE_MATERIAL_EXPS = dataList[15],
	AUTO_DECOMPOSE_FUN_ID = dataList[16],
	AUTO_DECOMPOSE_DEFAULT_QUALITY = dataList[17],
	BREAKOUT_ORANGE_TWO_PLAYER_LV = dataList[18],
	ORANGE_TWO_STONE_COUNT = dataList[19],
	ORANGE_TWO_MATERIAL_EQUIPMENT_COUNT = dataList[20],
	MATERIAL_CAPACITY_PET_START_LINE = dataList[21],
	MATERIAL_CAPACITY_INCR_PET_GAP = dataList[22],
	MATERIAL_CAPACITY_GAP_ADD_PERCENT = dataList[23],
	MATERIAL_CAPACITY_MAX_VALUE = dataList[24],
	MAX_BATCH_BREAKOUT_COUNT = dataList[25]
}

t_equipment_other_config.dataList = dataList

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

return t_equipment_other_config
