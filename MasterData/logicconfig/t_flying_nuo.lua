-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flying_nuo.lua

module("logicconfig.config.t_flying_nuo", package.seeall)

local title = {
	buyTimesPlan = 3,
	matId = 5,
	gameStartItem = 4,
	activityId = 1,
	prizePlan = 2
}
local dataList = {
	{
		6001,
		1,
		1,
		"10:6001:1",
		17001
	}
}
local t_flying_nuo = {
	[6001] = dataList[1]
}

t_flying_nuo.dataList = dataList

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

return t_flying_nuo
