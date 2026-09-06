-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fruit_ninja_progress_prize.lua

module("logicconfig.config.t_fruit_ninja_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1,
	needScore = 4
}
local dataList = {
	{
		475001,
		1,
		"60:1:600",
		400
	},
	{
		475001,
		2,
		"4:36:3",
		900
	},
	{
		475001,
		3,
		"8:1:2000000",
		1400
	},
	{
		475001,
		4,
		"4:510243:1",
		1900
	},
	{
		475001,
		5,
		"60:1:600",
		2400
	},
	{
		475001,
		6,
		"4:36:3",
		2900
	},
	{
		475001,
		7,
		"8:1:2000000",
		3400
	},
	{
		475001,
		8,
		"4:510243:1",
		3900
	},
	{
		475001,
		9,
		"60:1:600",
		4400
	},
	{
		475001,
		10,
		"8:1:2000000",
		5000
	},
	{
		475001,
		11,
		"60:1:600",
		5600
	},
	{
		475001,
		12,
		"4:510243:1",
		6200
	},
	{
		475001,
		13,
		"8:1:4000000",
		6800
	},
	{
		475001,
		14,
		"4:36:4",
		7400
	},
	{
		475001,
		15,
		"60:1:600",
		8000
	}
}
local t_fruit_ninja_progress_prize = {
	[475001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_fruit_ninja_progress_prize.dataList = dataList

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

return t_fruit_ninja_progress_prize
