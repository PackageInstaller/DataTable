-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_perfect_rule_universal.lua

module("logicconfig.config.t_perfect_rule_universal", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"YANLUO_ACTIVITY_TIME",
		"活动时间：2022.10.14-10.28"
	},
	{
		"YANLUO_CALL_JUMP",
		"ui#publicdragontabview#2#5"
	},
	{
		"YANLUO_RANK_JUMP",
		"func#618#15011"
	},
	{
		"HUOQILIN_CHALLENGEID",
		"111"
	},
	{
		"HUOQILIN_TITLE",
		"桀骜烈火·火麒麟"
	},
	{
		"HUOQILIN_ACTIVITY_TIME",
		"活动时间：2023.06.02-06.16"
	},
	{
		"HUOQILIN_SKIN_ID",
		"12015"
	},
	{
		"HUOQILIN_REBATE_JUMP",
		"func#545"
	},
	{
		"HUOQILIN_ITEMS",
		""
	},
	{
		"HUOQILIN_LOTTERY_JUMP",
		"ui#publicdragontabview#13#1"
	},
	{
		"HUOQILIN_RANK_JUMP",
		"func#618#12015"
	},
	{
		"HUOQILIN_YANGCHENG_JUMP",
		"mibao#xuwufuyao2"
	},
	{
		"JUSTICE_CHALLENGEID",
		"151"
	},
	{
		"JUSTICE_TITLE",
		"断魂行者·正义"
	},
	{
		"JUSTICE_ACTIVITY_TIME",
		"活动时间：2023.02.08-03.01"
	},
	{
		"JUSTICE_SKIN_ID",
		"16018"
	},
	{
		"JUSTICE_REBATE_JUMP",
		"func#545#3"
	},
	{
		"JUSTICE_ITEMS",
		""
	},
	{
		"JUSTICE_LOTTERY_JUMP",
		"ui#publicdragontabview#30#1"
	},
	{
		"JUSTICE_RANK_JUMP",
		"func#618#16018"
	},
	{
		"JUSTICE_YANGCHENG_JUMP",
		"mibao#tanggongyeyan3"
	}
}
local t_perfect_rule_universal = {
	YANLUO_ACTIVITY_TIME = dataList[1],
	YANLUO_CALL_JUMP = dataList[2],
	YANLUO_RANK_JUMP = dataList[3],
	HUOQILIN_CHALLENGEID = dataList[4],
	HUOQILIN_TITLE = dataList[5],
	HUOQILIN_ACTIVITY_TIME = dataList[6],
	HUOQILIN_SKIN_ID = dataList[7],
	HUOQILIN_REBATE_JUMP = dataList[8],
	HUOQILIN_ITEMS = dataList[9],
	HUOQILIN_LOTTERY_JUMP = dataList[10],
	HUOQILIN_RANK_JUMP = dataList[11],
	HUOQILIN_YANGCHENG_JUMP = dataList[12],
	JUSTICE_CHALLENGEID = dataList[13],
	JUSTICE_TITLE = dataList[14],
	JUSTICE_ACTIVITY_TIME = dataList[15],
	JUSTICE_SKIN_ID = dataList[16],
	JUSTICE_REBATE_JUMP = dataList[17],
	JUSTICE_ITEMS = dataList[18],
	JUSTICE_LOTTERY_JUMP = dataList[19],
	JUSTICE_RANK_JUMP = dataList[20],
	JUSTICE_YANGCHENG_JUMP = dataList[21]
}

t_perfect_rule_universal.dataList = dataList

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

return t_perfect_rule_universal
