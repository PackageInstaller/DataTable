-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_holy_dragon_clg_common.lua

module("logicconfig.config.t_ci_yuan_holy_dragon_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TIPS",
		"挑战时间：9:00--2:00"
	},
	{
		"RACEID",
		"10313"
	},
	{
		"RULE",
		"rule_ciyuanshenglongchallengemainview"
	},
	{
		"RANK",
		"次日重置排行榜，每日凌晨五点发放奖励内容"
	},
	{
		"RANK_CHALLENGE",
		"历史排行榜不重置，每隔十分钟刷新排行榜"
	},
	{
		"SHOP",
		"mibao#shuangjiekuanghuan6"
	},
	{
		"JUMP_TO",
		"func#618#10313"
	},
	{
		"REWARD",
		"4:206:1"
	}
}
local t_ci_yuan_holy_dragon_clg_common = {
	TIPS = dataList[1],
	RACEID = dataList[2],
	RULE = dataList[3],
	RANK = dataList[4],
	RANK_CHALLENGE = dataList[5],
	SHOP = dataList[6],
	JUMP_TO = dataList[7],
	REWARD = dataList[8]
}

t_ci_yuan_holy_dragon_clg_common.dataList = dataList

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

return t_ci_yuan_holy_dragon_clg_common
