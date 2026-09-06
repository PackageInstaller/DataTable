-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_planetarium_game_activity.lua

module("logicconfig.config.t_planetarium_game_activity", package.seeall)

local title = {
	activityId = 1,
	rulePlanId = 2
}
local dataList = {
	{
		280001,
		1
	},
	{
		280002,
		1
	},
	{
		280003,
		1
	},
	{
		280004,
		1
	}
}
local t_planetarium_game_activity = {
	[280001] = dataList[1],
	[280002] = dataList[2],
	[280003] = dataList[3],
	[280004] = dataList[4]
}

t_planetarium_game_activity.dataList = dataList

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

return t_planetarium_game_activity
