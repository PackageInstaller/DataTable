-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_campaign_invite_activity.lua

module("logicconfig.config.t_campaign_invite_activity", package.seeall)

local title = {
	inviteLimitPlan = 3,
	activityId = 1,
	prizePlan = 2
}
local dataList = {
	{
		95001,
		1,
		1
	},
	{
		95002,
		1,
		1
	},
	{
		95003,
		2,
		1
	},
	{
		95004,
		2,
		1
	},
	{
		95005,
		3,
		1
	},
	{
		95006,
		3,
		1
	},
	{
		95007,
		3,
		1
	},
	{
		95008,
		4,
		2
	}
}
local t_campaign_invite_activity = {
	[95001] = dataList[1],
	[95002] = dataList[2],
	[95003] = dataList[3],
	[95004] = dataList[4],
	[95005] = dataList[5],
	[95006] = dataList[6],
	[95007] = dataList[7],
	[95008] = dataList[8]
}

t_campaign_invite_activity.dataList = dataList

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

return t_campaign_invite_activity
