-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_god_dragon_activity.lua

module("logicconfig.config.t_divine_god_dragon_activity", package.seeall)

local title = {
	raceId = 3,
	activityId = 1,
	redPointId = 2
}
local dataList = {
	{
		346001,
		546,
		16022
	},
	{
		346002,
		546,
		15026
	}
}
local t_divine_god_dragon_activity = {
	[346001] = dataList[1],
	[346002] = dataList[2]
}

t_divine_god_dragon_activity.dataList = dataList

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

return t_divine_god_dragon_activity
