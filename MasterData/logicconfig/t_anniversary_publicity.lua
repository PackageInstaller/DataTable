-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_publicity.lua

module("logicconfig.config.t_anniversary_publicity", package.seeall)

local title = {
	planId = 3,
	funId = 4,
	activityId = 1,
	desc = 2
}
local dataList = {
	{
		147001,
		"线下专栏",
		1,
		542
	}
}
local t_anniversary_publicity = {
	[147001] = dataList[1]
}

t_anniversary_publicity.dataList = dataList

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

return t_anniversary_publicity
