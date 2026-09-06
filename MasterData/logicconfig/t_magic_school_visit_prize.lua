-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_visit_prize.lua

module("logicconfig.config.t_magic_school_visit_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	petPos = 5,
	storyId = 6,
	raceId = 7,
	activityId = 1,
	conPath = 4
}
local dataList = {
	{
		514001,
		1,
		"4:36:5",
		"goddessshop/board_ns_aoqi_01",
		{
			-153.7,
			-507.6,
			1
		},
		4820017,
		1203802
	},
	{
		514001,
		2,
		"4:36:5",
		"goddessshop/board_ns_aoqi_01",
		{
			-327.3,
			-507,
			1
		},
		4820019,
		1403702
	},
	{
		514001,
		3,
		"4:36:5",
		"goddessshop/board_ns_aoqi_02",
		{
			-37.5,
			-413.5,
			0.7
		},
		4820020,
		1403803
	},
	{
		514001,
		4,
		"4:36:5",
		"goddessshop/board_ns_aoqi_02",
		{
			-98.1,
			-513.8,
			1
		},
		4820018,
		1702401
	}
}
local t_magic_school_visit_prize = {
	[514001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_magic_school_visit_prize.dataList = dataList

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

return t_magic_school_visit_prize
