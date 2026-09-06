-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_common.lua

module("logicconfig.config.t_ji_clg_common", package.seeall)

local title = {
	ruleKeyNormalBoss = 5,
	ruleKeyNormal = 4,
	bubbleStrOne = 11,
	skinId = 2,
	bubbleStrTwo = 12,
	ruleKeyExtrem = 7,
	rewardImageName = 10,
	ruleNormal = 6,
	comPlanId = 1,
	ruleExtrem = 8,
	ruleKeyMain = 3,
	ruleExtremBottom = 9
}
local dataList = {
	{
		1,
		16009,
		"tonglinshijimainview_rule",
		"tonglinshijinorview_rule",
		"tonglinshijinorview_rule",
		"1、用自己的精灵采用系统养成进行挑战。\r\n2、通关破执关卡可以解锁助战精灵，助战精灵仅可在斩妄挑战中使用。\r\n3、通关破执关卡并上阵对应的奇迹五王可以激活全队buff。属性加成仅对助战精灵生效。",
		"tonglinshijiextview_rule",
		"使用与关卡属性相同的精灵破关并达成关卡目标即可充能。",
		"能量的总和到达<color=#00FFF5FF>5000</color>，且每种能量都在<color=#00FFF5FF>[900,1100]</color>区间内即可完成挑战。",
		"skill_816009",
		"通关获得",
		"通关获得"
	}
}
local t_ji_clg_common = {
	dataList[1]
}

t_ji_clg_common.dataList = dataList

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

return t_ji_clg_common
