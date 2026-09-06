-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_aruishi_challenge_activity.lua

module("logicconfig.config.t_dragon_king_aruishi_challenge_activity", package.seeall)

local title = {
	raceId = 2,
	activityId = 1,
	jumpTo = 3
}
local dataList = {
	{
		361001,
		11023,
		{
			"func#618#11023",
			"func#1066",
			"mibao#xinqionglongming5"
		}
	}
}
local t_dragon_king_aruishi_challenge_activity = {
	[361001] = dataList[1]
}

t_dragon_king_aruishi_challenge_activity.dataList = dataList

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

return t_dragon_king_aruishi_challenge_activity
