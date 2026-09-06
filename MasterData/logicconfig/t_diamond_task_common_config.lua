-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_diamond_task_common_config.lua

module("logicconfig.config.t_diamond_task_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FORMULA_WEIGHT",
		"1.8,1.5,0.8,0.5"
	},
	{
		"RECOMMEND_TASK_GIFT_TIMES",
		"2"
	},
	{
		"ACCUMULATE_ACTIVITY_PRZIE",
		"4:71003:1#4:71002:2#4:36:1#4:112:1#4:34:1"
	},
	{
		"ACTIVITY_PRZIE_COST_SCORE",
		"360"
	},
	{
		"ACTIVITY_DAILY_MAX_SCORE",
		"120"
	},
	{
		"ACTIVITY_TOTAL_SCORE",
		"720"
	},
	{
		"ACTIVITY_REWARD_TIPS",
		"1、每达到360点可领1个活跃大宝箱\n2、每日累计活跃上限为120点\n3、累计活跃总上限为720点\r\n4、活跃度宝箱奖励内容：传说之魂碎片*1、超能之魂碎片*2、神唤券*1、神炼石*1、顶级脆皮鸡腿*1（体力*120）"
	},
	{
		"ACTIVITY_REWARD_NOT_ENOUGH",
		"活跃积分达到%s以上可以领取一次奖励"
	},
	{
		"ACTIVITY_REWARD_ITEM",
		"1004:1210"
	}
}
local t_diamond_task_common_config = {
	FORMULA_WEIGHT = dataList[1],
	RECOMMEND_TASK_GIFT_TIMES = dataList[2],
	ACCUMULATE_ACTIVITY_PRZIE = dataList[3],
	ACTIVITY_PRZIE_COST_SCORE = dataList[4],
	ACTIVITY_DAILY_MAX_SCORE = dataList[5],
	ACTIVITY_TOTAL_SCORE = dataList[6],
	ACTIVITY_REWARD_TIPS = dataList[7],
	ACTIVITY_REWARD_NOT_ENOUGH = dataList[8],
	ACTIVITY_REWARD_ITEM = dataList[9]
}

t_diamond_task_common_config.dataList = dataList

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

return t_diamond_task_common_config
