-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_parallel_king_dragon_treasure.lua

module("logicconfig.config.t_parallel_king_dragon_treasure", package.seeall)

local title = {
	itemId = 5,
	name = 3,
	buffId = 4,
	activityId = 1,
	treasureId = 2
}
local dataList = {
	{
		519001,
		1,
		"金币",
		20066906,
		1554
	},
	{
		519001,
		2,
		"钻石",
		20066910,
		1555
	},
	{
		519001,
		3,
		"翡翠",
		20066914,
		1556
	},
	{
		519001,
		4,
		"暗噬石",
		0,
		1557
	}
}
local t_parallel_king_dragon_treasure = {
	[519001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_parallel_king_dragon_treasure.dataList = dataList

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

return t_parallel_king_dragon_treasure
