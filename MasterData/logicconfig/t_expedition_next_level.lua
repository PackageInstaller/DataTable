-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expedition_next_level.lua

module("logicconfig.config.t_expedition_next_level", package.seeall)

local title = {
	levelName = 2,
	nextLevel = 3,
	level = 1
}
local dataList = {
	{
		1,
		"第一层",
		{
			2
		}
	},
	{
		2,
		"第二层",
		{
			3,
			4
		}
	},
	{
		3,
		"第三层-普通"
	},
	{
		4,
		"第三层-噩梦"
	}
}
local t_expedition_next_level = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_expedition_next_level.dataList = dataList

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

return t_expedition_next_level
