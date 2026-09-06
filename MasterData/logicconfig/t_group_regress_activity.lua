-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_regress_activity.lua

module("logicconfig.config.t_group_regress_activity", package.seeall)

local title = {
	regressDays = 3,
	maxInvitePlayerCnt = 6,
	inviteRegressPlayerPrize = 4,
	progressActivityItemId = 2,
	maxInviteNewPlayerCnt = 7,
	maxInviteRegressPlayerCnt = 8,
	activityId = 1,
	inviteNewPlayerPrize = 5
}
local dataList = {
	{
		598001,
		598002,
		28,
		"10:598002:10",
		"10:598002:10",
		10,
		5,
		5
	}
}
local t_group_regress_activity = {
	[598001] = dataList[1]
}

t_group_regress_activity.dataList = dataList

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

return t_group_regress_activity
