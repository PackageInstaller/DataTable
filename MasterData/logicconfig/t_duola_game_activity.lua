-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duola_game_activity.lua

module("logicconfig.config.t_duola_game_activity", package.seeall)

local title = {
	redPointId = 3,
	comPlanId = 2,
	activityId = 1
}
local dataList = {
	{
		279001,
		1,
		501
	},
	{
		279002,
		2,
		561
	},
	{
		279003,
		2,
		561
	}
}
local t_duola_game_activity = {
	[279001] = dataList[1],
	[279002] = dataList[2],
	[279003] = dataList[3]
}

t_duola_game_activity.dataList = dataList

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

return t_duola_game_activity
