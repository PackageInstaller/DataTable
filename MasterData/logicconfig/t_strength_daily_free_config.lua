-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_strength_daily_free_config.lua

module("logicconfig.config.t_strength_daily_free_config", package.seeall)

local title = {
	index = 1,
	endTime = 3,
	pushId = 4,
	startTime = 2
}
local dataList = {
	{
		0,
		"06:00:00",
		"23:59:59",
		2
	},
	{
		1,
		"12:00:00",
		"23:59:59",
		11
	},
	{
		2,
		"18:00:00",
		"23:59:59",
		12
	}
}
local t_strength_daily_free_config = {
	[0] = dataList[1],
	dataList[2],
	dataList[3]
}

t_strength_daily_free_config.dataList = dataList

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

return t_strength_daily_free_config
