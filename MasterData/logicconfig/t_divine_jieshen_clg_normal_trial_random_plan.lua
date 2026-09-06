-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_normal_trial_random_plan.lua

module("logicconfig.config.t_divine_jieshen_clg_normal_trial_random_plan", package.seeall)

local title = {
	randomPlanId = 1,
	name = 3,
	trialMode = 2,
	params = 5,
	imgUrl = 4
}
local dataList = {
	{
		1,
		1,
		"挑战试炼",
		"ui/emoji/nianfei/emoji_baodatui"
	},
	{
		1,
		2,
		"欧气爆棚",
		"ui/emoji/nianfei/emoji_shanliangdengchang"
	},
	{
		1,
		3,
		"迷境寻踪",
		"ui/emoji/nianfei/emoji_touxiao",
		{
			activityId = "138005",
			levelId = "2"
		}
	},
	{
		1,
		4,
		"答题试炼",
		"ui/emoji/nianfei/emoji_wuyu",
		{
			problemCount = "5",
			problemPlanId = "2"
		}
	}
}
local t_divine_jieshen_clg_normal_trial_random_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_jieshen_clg_normal_trial_random_plan.dataList = dataList

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

return t_divine_jieshen_clg_normal_trial_random_plan
