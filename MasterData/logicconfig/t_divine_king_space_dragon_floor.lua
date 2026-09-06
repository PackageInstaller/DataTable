-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_space_dragon_floor.lua

module("logicconfig.config.t_divine_king_space_dragon_floor", package.seeall)

local title = {
	stagePlanId = 4,
	prize = 3,
	floorId = 2,
	activityId = 1
}
local dataList = {
	{
		521001,
		1,
		"4:510581:10",
		1
	},
	{
		521001,
		2,
		"4:510581:10",
		2
	},
	{
		521001,
		3,
		"4:510581:10",
		3
	},
	{
		521001,
		4,
		"4:510581:10",
		4
	},
	{
		521001,
		5,
		"4:510581:30",
		5
	},
	{
		521001,
		6,
		"4:510581:30",
		6
	}
}
local t_divine_king_space_dragon_floor = {
	[521001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_king_space_dragon_floor.dataList = dataList

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

return t_divine_king_space_dragon_floor
