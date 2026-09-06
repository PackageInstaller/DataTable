-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ci_yuan_extreme_tab.lua

module("logicconfig.config.t_divine_ci_yuan_extreme_tab", package.seeall)

local title = {
	ruleDescription = 9,
	name = 7,
	buffPlanId = 6,
	tabId = 2,
	buffSelect = 5,
	openTime = 3,
	iconPath = 8,
	fullMonster = 4,
	activityId = 1
}
local dataList = {
	{
		302001,
		1,
		"2023-09-28T05:00:00",
		false,
		true,
		1,
		"空间试炼",
		"ui/icon/character/icon_10313_ciyuanshenglong",
		"击败敌阵时存活指定数量精灵即可过关"
	},
	{
		302001,
		2,
		"2023-09-29T05:00:00",
		false,
		true,
		1,
		"次元试炼",
		"ui/icon/divineciyuan/board_shenyaociyuanlong_15",
		"1.击败敌阵时，己阵出手次数超过指定次数即可过关\r\n2.同一层关卡内，上阵精灵不可重复上阵"
	},
	{
		302001,
		3,
		"2023-09-30T05:00:00",
		true,
		true,
		1,
		"神曜试炼",
		"ui/icon/character/icon_14016_shenyaoguangciyuan",
		"1.己阵和敌阵均可上阵9只精灵，击败敌阵全体精灵即可过关\r\n2.敌阵受到的群体伤害降低\r\n3.同一层关卡内，上阵精灵不可重复上阵"
	},
	{
		302002,
		1,
		"2023-09-28T05:00:00",
		false,
		true,
		1,
		"空间试炼",
		"ui/icon/character/icon_10313_ciyuanshenglong",
		"击败敌阵时存活指定数量精灵即可过关"
	},
	{
		302002,
		2,
		"2023-09-29T05:00:00",
		false,
		true,
		1,
		"次元试炼",
		"ui/icon/divineciyuan/board_shenyaociyuanlong_15",
		"1.击败敌阵时，己阵出手次数超过指定次数即可过关\r\n2.同一层关卡内，上阵精灵不可重复上阵"
	},
	{
		302002,
		3,
		"2023-09-30T05:00:00",
		true,
		true,
		1,
		"神曜试炼",
		"ui/icon/character/icon_14016_shenyaoguangciyuan",
		"1.己阵和敌阵均可上阵9只精灵，击败敌阵全体精灵即可过关\r\n2.敌阵受到的群体伤害降低\r\n3.同一层关卡内，上阵精灵不可重复上阵"
	}
}
local t_divine_ci_yuan_extreme_tab = {
	[302001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[302002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_ci_yuan_extreme_tab.dataList = dataList

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

return t_divine_ci_yuan_extreme_tab
