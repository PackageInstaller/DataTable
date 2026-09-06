-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_youth_activity.lua

module("logicconfig.config.t_dream_youth_activity", package.seeall)

local title = {
	packId = 4,
	itemId = 3,
	showPetId = 5,
	activityId = 1,
	strengthenPlanId = 2
}
local dataList = {
	{
		93001,
		1,
		"10:93001:1",
		"50012#50013#50014",
		"6"
	}
}
local t_dream_youth_activity = {
	[93001] = dataList[1]
}

t_dream_youth_activity.dataList = dataList

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

return t_dream_youth_activity
