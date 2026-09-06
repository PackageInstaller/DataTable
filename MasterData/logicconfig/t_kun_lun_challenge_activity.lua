-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_lun_challenge_activity.lua

module("logicconfig.config.t_kun_lun_challenge_activity", package.seeall)

local title = {
	extremeCardNum = 5,
	comPlanId = 6,
	dailyCommonTimes = 2,
	commonCreepsMasterId = 3,
	activityId = 1,
	extremePrize = 4
}
local dataList = {
	{
		304001,
		3,
		200001,
		"100:13013:1:1",
		3,
		1
	},
	{
		304002,
		3,
		200001,
		"8:1:1",
		3,
		2
	}
}
local t_kun_lun_challenge_activity = {
	[304001] = dataList[1],
	[304002] = dataList[2]
}

t_kun_lun_challenge_activity.dataList = dataList

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

return t_kun_lun_challenge_activity
