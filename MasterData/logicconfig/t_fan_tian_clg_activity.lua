-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_tian_clg_activity.lua

module("logicconfig.config.t_fan_tian_clg_activity", package.seeall)

local title = {
	buffPlanId = 3,
	giftJump = 8,
	redPointId = 2,
	skinId = 4,
	ruleKey = 9,
	rankJump = 7,
	shopJump = 5,
	activityId = 1,
	lotteryJump = 6
}
local dataList = {
	{
		313001,
		524,
		0,
		17011,
		"mibao#longmaijuexing1",
		"func#965",
		"func#618#17011",
		"",
		"FantianchallengeView_rules"
	},
	{
		313002,
		0,
		0,
		12035,
		"mibao#longmaijuexing1",
		"ui#lottery",
		"func#618#12035",
		"func#545#3",
		"divineluciferchallengeview_rules"
	},
	{
		313003,
		0,
		0,
		12043,
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"func#618#12043",
		"func#1181",
		"yqzhaohuanmychallengeview_rules"
	}
}
local t_fan_tian_clg_activity = {
	[313001] = dataList[1],
	[313002] = dataList[2],
	[313003] = dataList[3]
}

t_fan_tian_clg_activity.dataList = dataList

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

return t_fan_tian_clg_activity
