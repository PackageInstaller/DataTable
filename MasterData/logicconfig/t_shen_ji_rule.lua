-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shen_ji_rule.lua

module("logicconfig.config.t_shen_ji_rule", package.seeall)

local title = {
	actId = 1,
	ruleKey = 6,
	ruleId = 2,
	pageId = 3,
	resPath = 4,
	desc = 5
}
local dataList = {
	{
		312001,
		1,
		1,
		"ui/bigbg/views/challenges/shenji/board_shenjisala_tc01.png",
		"关卡结算时，己阵剩余总血量的百分比乘以关卡最大神恩值即是本关获取的神恩值",
		""
	},
	{
		312001,
		1,
		2,
		"ui/bigbg/views/challenges/shenji/board_shenjisala_tc02.png",
		"根据神恩值，【道途】会给予精灵在【破邪】关卡中的属性加成",
		""
	},
	{
		312001,
		2,
		1,
		"ui/bigbg/views/challenges/shenji/board_shenjisala_tc03.png",
		"每轮可以进入挑战3次，失败后血量和挑战次数重置",
		""
	},
	{
		312001,
		2,
		2,
		"ui/bigbg/views/challenges/shenji/board_shenjisala_tc04.png",
		"挑战成功后，次日05：00前会进入冷却时间；冷却结束后即可再次挑战",
		""
	},
	{
		312001,
		2,
		3,
		"ui/bigbg/views/challenges/shenji/board_shenjisala_tc05.png",
		"预言可以不消耗次数地演习，BOSS的承伤不会记录",
		""
	},
	{
		312002,
		1,
		1,
		"",
		"",
		"divinelounamainview1_rule"
	},
	{
		312002,
		2,
		1,
		"",
		"",
		"divinelounamainview2_rule"
	},
	{
		312003,
		1,
		1,
		"",
		"",
		"divinelounamainview1_rule"
	},
	{
		312003,
		2,
		1,
		"",
		"",
		"divinelounamainview2_rule"
	}
}
local t_shen_ji_rule = {
	[312001] = {
		{
			dataList[1],
			dataList[2]
		},
		{
			dataList[3],
			dataList[4],
			dataList[5]
		}
	},
	[312002] = {
		{
			dataList[6]
		},
		{
			dataList[7]
		}
	},
	[312003] = {
		{
			dataList[8]
		},
		{
			dataList[9]
		}
	}
}

t_shen_ji_rule.dataList = dataList

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

return t_shen_ji_rule
