-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_dungeon_activity.lua

module("logicconfig.config.t_bone_dragon_dungeon_activity", package.seeall)

local title = {
	dailyGameTimes = 2,
	progressMpKey = 3,
	buffPlanId = 4,
	price = 5,
	activityId = 1
}
local dataList = {
	{
		490001,
		5,
		490001,
		1,
		"10:490002"
	}
}
local t_bone_dragon_dungeon_activity = {
	[490001] = dataList[1]
}

t_bone_dragon_dungeon_activity.dataList = dataList

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

return t_bone_dragon_dungeon_activity
