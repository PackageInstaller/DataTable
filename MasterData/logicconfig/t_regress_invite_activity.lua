-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regress_invite_activity.lua

module("logicconfig.config.t_regress_invite_activity", package.seeall)

local title = {
	taskPlan = 4,
	dailyTaskCount = 3,
	ruleDesc = 7,
	funcId = 6,
	useCodePrize = 5,
	activityId = 1,
	invitePrizePlan = 2
}
local dataList = {
	{
		74001,
		1,
		5,
		1,
		"104:2:100",
		370,
		"1、与回归玩家一起完成每日回归任务\n\r\n2、每日上限回归任务为5条\n\r\n3、每个任务内容仅限今日完成，次日刷新\n"
	}
}
local t_regress_invite_activity = {
	[74001] = dataList[1]
}

t_regress_invite_activity.dataList = dataList

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

return t_regress_invite_activity
