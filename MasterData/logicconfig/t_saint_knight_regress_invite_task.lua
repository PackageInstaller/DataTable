-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_regress_invite_task.lua

module("logicconfig.config.t_saint_knight_regress_invite_task", package.seeall)

local title = {
	inviteCount = 3,
	prize = 4,
	activityId = 1,
	taskId = 2
}
local dataList = {
	{
		483001,
		1,
		1,
		"10:483001:10"
	},
	{
		483001,
		2,
		2,
		"10:483001:10"
	},
	{
		483001,
		3,
		3,
		"10:483001:10"
	}
}
local t_saint_knight_regress_invite_task = {
	[483001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_saint_knight_regress_invite_task.dataList = dataList

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

return t_saint_knight_regress_invite_task
