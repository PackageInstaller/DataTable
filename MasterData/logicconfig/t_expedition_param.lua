-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expedition_param.lua

module("logicconfig.config.t_expedition_param", package.seeall)

local title = {
	paramValue = 2,
	paramKey = 1
}
local dataList = {
	{
		"chooseBuffNum",
		"3"
	},
	{
		"choosePetNum",
		"3"
	},
	{
		"chooseGoodsNum",
		"3"
	},
	{
		"maxSight",
		"4"
	},
	{
		"reviveCostItem",
		"4:71:1"
	},
	{
		"hpAddRatePerFight",
		"2000"
	},
	{
		"period",
		"1"
	},
	{
		"retreatMsgType",
		"2"
	},
	{
		"enableSkip",
		"1"
	},
	{
		"skipTime",
		"5"
	},
	{
		"refreshBuffCost",
		"105:136:50"
	},
	{
		"sweepNeedLv",
		"25"
	},
	{
		"weeklyMaxTimes",
		"3"
	},
	{
		"weeklyCanEnterDesc",
		"失落遗迹中触发地图事件将消耗每周次数，消耗次数后当天退出后可再次进入。\n\n本周剩余次数：%s/%s\n\n当前遗迹可进行探索"
	},
	{
		"weeklyNotCanEnterDesc",
		"本周失落遗迹探索次数不足，无法进入！\n\n本周剩余次数：%s/%s"
	},
	{
		"myBuffId",
		""
	}
}
local t_expedition_param = {
	chooseBuffNum = dataList[1],
	choosePetNum = dataList[2],
	chooseGoodsNum = dataList[3],
	maxSight = dataList[4],
	reviveCostItem = dataList[5],
	hpAddRatePerFight = dataList[6],
	period = dataList[7],
	retreatMsgType = dataList[8],
	enableSkip = dataList[9],
	skipTime = dataList[10],
	refreshBuffCost = dataList[11],
	sweepNeedLv = dataList[12],
	weeklyMaxTimes = dataList[13],
	weeklyCanEnterDesc = dataList[14],
	weeklyNotCanEnterDesc = dataList[15],
	myBuffId = dataList[16]
}

t_expedition_param.dataList = dataList

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

return t_expedition_param
