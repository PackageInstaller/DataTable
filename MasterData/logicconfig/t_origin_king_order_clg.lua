-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_order_clg.lua

module("logicconfig.config.t_origin_king_order_clg", package.seeall)

local title = {
	ningzhiBuffDesc = 2,
	jumpStrOne = 6,
	skinId = 5,
	jumpStrThree = 8,
	jumpRedIdThree = 12,
	jumpRedIdFour = 13,
	jumpStrTwo = 7,
	jumpRedIdTwo = 11,
	stormBuffDesc = 3,
	jumpRedIdOne = 10,
	jumpStrFour = 9,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		569001,
		"每个大回合开始时，己阵全体将受到己阵战力最高的精灵攻击力*150%的伤害",
		"进入战斗时，与风暴距离为1的精灵被施加一次无法行动（1回合），与风暴距离为2的精灵被施加禁气（1回合）",
		"originkingorderclgmainview_rule",
		11040,
		"event#gotofirstpassrankview#569001",
		"func#618#11040",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"",
		"",
		"",
		""
	}
}
local t_origin_king_order_clg = {
	[569001] = dataList[1]
}

t_origin_king_order_clg.dataList = dataList

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

return t_origin_king_order_clg
