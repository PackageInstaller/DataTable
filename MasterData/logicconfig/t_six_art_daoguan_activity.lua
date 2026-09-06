-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_six_art_daoguan_activity.lua

module("logicconfig.config.t_six_art_daoguan_activity", package.seeall)

local title = {
	activityId = 1
}
local dataList = {
	{
		447001
	}
}
local t_six_art_daoguan_activity = {
	[447001] = dataList[1]
}

t_six_art_daoguan_activity.dataList = dataList

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

return t_six_art_daoguan_activity
