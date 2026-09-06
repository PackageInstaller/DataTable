-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_open_time.lua

module("logicconfig.config.t_dark_dragon_open_time", package.seeall)

local title = {
	titleName = 5,
	seasonId = 1,
	endTime = 3,
	scoreIcon = 4,
	startTime = 2
}
local dataList = {
	{
		1,
		"2021-08-19T05:00:00",
		"2021-09-02T05:00:00",
		"icon_nengliangqiu",
		"深境：暗涌"
	}
}
local t_dark_dragon_open_time = {
	dataList[1]
}

t_dark_dragon_open_time.dataList = dataList

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

return t_dark_dragon_open_time
