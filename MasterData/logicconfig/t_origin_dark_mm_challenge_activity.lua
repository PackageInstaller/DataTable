-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mm_challenge_activity.lua

module("logicconfig.config.t_origin_dark_mm_challenge_activity", package.seeall)

local title = {
	jumpToPrize = 6,
	jumpToRank = 5,
	jumpToPack = 8,
	detailDesc = 9,
	passPrize = 2,
	jumpToShop = 7,
	petRaceIds = 3,
	stageDetailDesc = 11,
	raceId = 4,
	ruleKeyMain = 10,
	activityId = 1
}
local dataList = {
	{
		603001,
		"4:510798:100",
		{
			11041,
			11042,
			12046,
			13031,
			14044,
			15050
		},
		15050,
		"func#618#15050",
		"mibao#mengduiyangcheng",
		"ui#lottery",
		"func#95#mengduiyangcheng#all#251301",
		"每收集一只源起梦之队精灵将给我方全属性提升，激活梦之力",
		"origindarkmmclg_rule",
		"1、布阵时请先给当前上阵精灵分配行动值，战斗中，精灵触发指定行为将会扣除行动值，行动值不足时，精灵将无法行动\r\n2、敌阵获得30%免伤及非伤免伤，敌阵精灵在攻击时吸收目标15%全属性\r\n3、通关后封印本次上阵的所有精灵，后续关卡不可上阵"
	}
}
local t_origin_dark_mm_challenge_activity = {
	[603001] = dataList[1]
}

t_origin_dark_mm_challenge_activity.dataList = dataList

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

return t_origin_dark_mm_challenge_activity
