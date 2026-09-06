-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_preheat.lua

module("logicconfig.config.t_anniversary_preheat", package.seeall)

local title = {
	sharePrize = 5,
	danMuScore = 3,
	sharePicPath = 6,
	danMuTimes = 2,
	shareAddScore = 4,
	activityId = 1
}
local dataList = {
	{
		141001,
		3,
		1,
		3,
		"104:2:20",
		""
	}
}
local t_anniversary_preheat = {
	[141001] = dataList[1]
}

t_anniversary_preheat.dataList = dataList

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

return t_anniversary_preheat
