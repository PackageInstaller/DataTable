-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_task_team_config.lua

module("logicconfig.config.t_saint_knight_task_team_config", package.seeall)

local title = {
	activityId = 1,
	activityItemId = 2,
	teamMemberCount = 3
}
local dataList = {
	{
		175022,
		175022,
		4
	}
}
local t_saint_knight_task_team_config = {
	[175022] = dataList[1]
}

t_saint_knight_task_team_config.dataList = dataList

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

return t_saint_knight_task_team_config
