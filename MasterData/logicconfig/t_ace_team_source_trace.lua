-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ace_team_source_trace.lua

module("logicconfig.config.t_ace_team_source_trace", package.seeall)

local title = {
	groupId = 1,
	nodeId = 2,
	point = 3,
	pos = 4
}
local dataList = {
	{
		1,
		4,
		100,
		{
			-160,
			-55
		}
	},
	{
		1,
		7,
		100,
		{
			0,
			15
		}
	},
	{
		1,
		10,
		100,
		{
			160,
			-55
		}
	}
}
local t_ace_team_source_trace = {
	{
		[4] = dataList[1],
		[7] = dataList[2],
		[10] = dataList[3]
	}
}

t_ace_team_source_trace.dataList = dataList

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

return t_ace_team_source_trace
