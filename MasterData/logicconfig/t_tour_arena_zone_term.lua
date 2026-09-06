-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tour_arena_zone_term.lua

module("logicconfig.config.t_tour_arena_zone_term", package.seeall)

local title = {
	termId = 1
}
local dataList = {
	{
		1
	},
	{
		2
	},
	{
		3
	},
	{
		4
	},
	{
		5
	},
	{
		6
	}
}
local t_tour_arena_zone_term = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_tour_arena_zone_term.dataList = dataList

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

return t_tour_arena_zone_term
