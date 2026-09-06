-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_best_dragon_soul_progress_prize.lua

module("logicconfig.config.t_best_dragon_soul_progress_prize", package.seeall)

local title = {
	prizeId = 3,
	likeTime = 6,
	prize = 5,
	type = 2,
	progress = 4,
	activityId = 1
}
local dataList = {
	{
		358001,
		1,
		1,
		40,
		"4:36:2",
		0
	},
	{
		358001,
		1,
		2,
		120,
		"8:1:1250000",
		0
	},
	{
		358001,
		1,
		3,
		160,
		"4:400002:25",
		0
	},
	{
		358001,
		1,
		4,
		240,
		"4:36:3",
		0
	},
	{
		358001,
		1,
		5,
		280,
		"8:1:1000000",
		0
	},
	{
		358001,
		1,
		6,
		360,
		"4:400002:25",
		0
	},
	{
		358001,
		2,
		1,
		40,
		"4:36:2",
		3
	},
	{
		358001,
		2,
		2,
		120,
		"8:1:1000000",
		3
	},
	{
		358001,
		2,
		3,
		160,
		"4:400002:25",
		3
	},
	{
		358001,
		2,
		4,
		240,
		"4:36:3",
		3
	},
	{
		358001,
		2,
		5,
		280,
		"8:1:1000000",
		3
	},
	{
		358001,
		2,
		6,
		360,
		"4:400002:25",
		3
	}
}
local t_best_dragon_soul_progress_prize = {
	[358001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_best_dragon_soul_progress_prize.dataList = dataList

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

return t_best_dragon_soul_progress_prize
