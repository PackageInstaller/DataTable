-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_man_wang_challenge_type.lua

module("logicconfig.config.t_tian_man_wang_challenge_type", package.seeall)

local title = {
	challengeType = 1,
	name = 2,
	ruleKey = 7,
	unlockCondition = 3,
	desc = 9,
	buyTimesPlanId = 6,
	viewName = 8,
	hasDailyTimesLimit = 4,
	freeDailyTimes = 5
}
local dataList = {
	{
		1,
		"苍木千叶",
		nil,
		false,
		0,
		0,
		"tianmankingchallenge",
		"",
		"解锁契约精灵，唤醒天蛮王的力量"
	},
	{
		2,
		"森罗万象",
		nil,
		true,
		5,
		2,
		"tianmankingchallenge",
		"",
		"必须上阵助战天蛮王，且天蛮王不能阵亡"
	},
	{
		3,
		"战绝八荒",
		{
			2,
			10
		},
		true,
		2,
		3,
		"tianmankingchallenge",
		"",
		"通关战绝八荒前<color=#FEE04AFF>5999</color>名玩家\n可得<color=#FEE04AFF>专属头像框</color>，精灵背包中<color=#FEE04AFF>展示</color>天蛮王显示<color=#FEE04AFF>获得名次</color>"
	}
}
local t_tian_man_wang_challenge_type = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_tian_man_wang_challenge_type.dataList = dataList

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

return t_tian_man_wang_challenge_type
