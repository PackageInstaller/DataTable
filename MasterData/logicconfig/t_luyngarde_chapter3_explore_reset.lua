-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter3_explore_reset.lua

module("logicconfig.config.t_luyngarde_chapter3_explore_reset", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	times = 2
}
local dataList = {
	{
		466001,
		1,
		"66:18:5"
	},
	{
		466001,
		2,
		"66:18:5"
	},
	{
		466001,
		3,
		"66:18:10"
	},
	{
		466001,
		4,
		"66:18:10"
	},
	{
		466001,
		5,
		"66:18:15"
	},
	{
		466001,
		6,
		"66:18:15"
	}
}
local t_luyngarde_chapter3_explore_reset = {
	[466001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_luyngarde_chapter3_explore_reset.dataList = dataList

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

return t_luyngarde_chapter3_explore_reset
