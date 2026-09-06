-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_stripe_params.lua

module("logicconfig.config.t_holy_stripe_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SMELT_REFUND_EXP_RATE",
		"0.7"
	},
	{
		"STRENGTHEN_MATERIAL_IDS",
		"30010,30004,30005,30006"
	},
	{
		"STRENGTHEN_MATERIAL_EXPS",
		"50,100,1000,5000"
	},
	{
		"QUENCHING_UNLOCK_LVS",
		"0,0,10,15,20"
	},
	{
		"SMELT_DAYS",
		"0,1,3,7"
	},
	{
		"NUM_UP",
		"2000"
	},
	{
		"AUTO_LOCK_LEVEL",
		"20"
	},
	{
		"STRENGTHEN_COST_COINS",
		"1:5,1:5,1:5,1:5,1:5"
	},
	{
		"MAX_SMELT_LIMIT",
		"300"
	},
	{
		"MAX_STRENGTHEN_LIMIT",
		"300"
	},
	{
		"MAX_HOLYSTRIPES_SUIT",
		"1:100351:1:20:105001,105002,105003,105004,105023#2:100352:1:20:205001,205002,205003,205004,205023#3:100353:1:20:305001,305002,305003,305004,305023#4:100354:1:20:405001,405002,405003,405004,405023#5:100355:1:20:505001,505002,505003,505004,505023"
	},
	{
		"MAX_SUIT_GROUP_COUNT",
		"30"
	},
	{
		"MAX_SUIT_COUNT",
		"30"
	},
	{
		"SUIT_NAME_MAX_LEN",
		"6"
	},
	{
		"DEFAULT_GROUP_NAME",
		"默认分组"
	},
	{
		"MAX_RECOMMEND_CALCULATE",
		"3"
	},
	{
		"MAX_SUBATTR_PRIORITY",
		"8"
	},
	{
		"QUICK_ACTION_SELECT_LIMIT",
		"500"
	}
}
local t_holy_stripe_params = {
	SMELT_REFUND_EXP_RATE = dataList[1],
	STRENGTHEN_MATERIAL_IDS = dataList[2],
	STRENGTHEN_MATERIAL_EXPS = dataList[3],
	QUENCHING_UNLOCK_LVS = dataList[4],
	SMELT_DAYS = dataList[5],
	NUM_UP = dataList[6],
	AUTO_LOCK_LEVEL = dataList[7],
	STRENGTHEN_COST_COINS = dataList[8],
	MAX_SMELT_LIMIT = dataList[9],
	MAX_STRENGTHEN_LIMIT = dataList[10],
	MAX_HOLYSTRIPES_SUIT = dataList[11],
	MAX_SUIT_GROUP_COUNT = dataList[12],
	MAX_SUIT_COUNT = dataList[13],
	SUIT_NAME_MAX_LEN = dataList[14],
	DEFAULT_GROUP_NAME = dataList[15],
	MAX_RECOMMEND_CALCULATE = dataList[16],
	MAX_SUBATTR_PRIORITY = dataList[17],
	QUICK_ACTION_SELECT_LIMIT = dataList[18]
}

t_holy_stripe_params.dataList = dataList

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

return t_holy_stripe_params
