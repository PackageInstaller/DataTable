-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_regress_activity.lua

module("logicconfig.config.t_saint_knight_regress_activity", package.seeall)

local title = {
	inviteCountLimit = 2,
	lotteryCost = 6,
	redPointId = 5,
	regressLoginInterval = 3,
	bindCodePrize = 4,
	templateId = 7,
	activityId = 1
}
local dataList = {
	{
		483001,
		3,
		21,
		"10:483001:10",
		702,
		"10:483001:10",
		80
	}
}
local t_saint_knight_regress_activity = {
	[483001] = dataList[1]
}

t_saint_knight_regress_activity.dataList = dataList

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

return t_saint_knight_regress_activity
