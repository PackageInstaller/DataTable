-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_new_puzzle_prize.lua

module("logicconfig.config.t_tutor_system_new_puzzle_prize", package.seeall)

local title = {
	prizeId = 1,
	prize = 3,
	needPointIds = 2
}
local dataList = {
	{
		1,
		{
			0,
			1,
			2,
			3,
			4
		},
		"4:510418:2"
	},
	{
		2,
		{
			5,
			6,
			7,
			8,
			9
		},
		"4:510418:2"
	},
	{
		3,
		{
			10,
			11,
			12,
			13,
			14
		},
		"4:12102:20"
	},
	{
		4,
		{
			0,
			5,
			10
		},
		"4:510022:20"
	},
	{
		5,
		{
			1,
			6,
			11
		},
		"4:36:20"
	},
	{
		6,
		{
			2,
			7,
			12
		},
		"4:36:20"
	},
	{
		7,
		{
			3,
			8,
			13
		},
		"4:36:20"
	},
	{
		8,
		{
			4,
			9,
			14
		},
		"4:36:20"
	}
}
local t_tutor_system_new_puzzle_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_tutor_system_new_puzzle_prize.dataList = dataList

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

return t_tutor_system_new_puzzle_prize
