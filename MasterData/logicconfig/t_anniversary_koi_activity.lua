-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_koi_activity.lua

module("logicconfig.config.t_anniversary_koi_activity", package.seeall)

local title = {
	speed = 4,
	templateId = 2,
	round = 5,
	jumpTo = 3,
	msgTemplateId = 6,
	activityId = 1
}
local dataList = {
	{
		261001,
		197,
		"mibao#GodDiamond",
		0.2,
		2,
		61
	}
}
local t_anniversary_koi_activity = {
	[261001] = dataList[1]
}

t_anniversary_koi_activity.dataList = dataList

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

return t_anniversary_koi_activity
