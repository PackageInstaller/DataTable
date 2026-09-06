-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wishtree_wish.lua

module("logicconfig.config.t_wishtree_wish", package.seeall)

local title = {
	id = 2,
	unlockValue = 4,
	planId = 1,
	unlockTime = 3
}
local dataList = {
	{
		1,
		1,
		"2022-12-13 00:00:00",
		100
	},
	{
		1,
		2,
		"2022-12-15 00:00:00",
		100
	},
	{
		1,
		3,
		"2022-12-18 00:00:00",
		100
	},
	{
		1,
		4,
		"2022-12-20 00:00:00",
		100
	}
}
local t_wishtree_wish = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_wishtree_wish.dataList = dataList

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

return t_wishtree_wish
