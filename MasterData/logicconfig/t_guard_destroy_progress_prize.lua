-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_destroy_progress_prize.lua

module("logicconfig.config.t_guard_destroy_progress_prize", package.seeall)

local title = {
	prizeId = 3,
	prize = 5,
	progress = 4,
	stageType = 2,
	activityId = 1
}
local dataList = {
	{
		474001,
		1,
		1,
		8,
		"8:1:500000"
	},
	{
		474001,
		1,
		2,
		16,
		"4:281:10"
	},
	{
		474001,
		1,
		3,
		24,
		"4:111:10"
	},
	{
		474001,
		1,
		4,
		32,
		"4:12102:10"
	},
	{
		474001,
		1,
		5,
		40,
		"4:7008:100"
	},
	{
		474001,
		2,
		1,
		8,
		"8:1:500000"
	},
	{
		474001,
		2,
		2,
		16,
		"4:281:10"
	},
	{
		474001,
		2,
		3,
		24,
		"4:36:10"
	},
	{
		474001,
		2,
		4,
		32,
		"4:11002:30000"
	},
	{
		474001,
		2,
		5,
		40,
		"4:30006:50"
	},
	{
		474002,
		1,
		1,
		10,
		"4:30006:25"
	},
	{
		474002,
		1,
		2,
		20,
		"4:30006:25"
	},
	{
		474002,
		1,
		3,
		30,
		"4:36:5"
	},
	{
		474002,
		1,
		4,
		40,
		"4:12102:5"
	},
	{
		474002,
		1,
		5,
		50,
		"4:90214:1"
	},
	{
		474002,
		2,
		1,
		10,
		"4:11002:15000"
	},
	{
		474002,
		2,
		2,
		20,
		"4:11002:15000"
	},
	{
		474002,
		2,
		3,
		30,
		"4:30006:50"
	},
	{
		474002,
		2,
		4,
		40,
		"4:36:5"
	},
	{
		474002,
		2,
		5,
		50,
		"4:12102:5"
	}
}
local t_guard_destroy_progress_prize = {
	[474001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		}
	},
	[474002] = {
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		}
	}
}

t_guard_destroy_progress_prize.dataList = dataList

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

return t_guard_destroy_progress_prize
