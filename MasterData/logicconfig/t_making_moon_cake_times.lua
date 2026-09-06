-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_making_moon_cake_times.lua

module("logicconfig.config.t_making_moon_cake_times", package.seeall)

local title = {
	buyTimesPlanId = 1,
	cost = 3,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:187:25"
	},
	{
		1,
		2,
		"105:187:50"
	}
}
local t_making_moon_cake_times = {
	{
		dataList[1],
		dataList[2]
	}
}

t_making_moon_cake_times.dataList = dataList

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

return t_making_moon_cake_times
