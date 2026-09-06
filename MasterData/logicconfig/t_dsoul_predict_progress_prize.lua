-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dsoul_predict_progress_prize.lua

module("logicconfig.config.t_dsoul_predict_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		428001,
		1,
		10,
		"60:1:600"
	},
	{
		428001,
		2,
		25,
		"4:400002:20"
	},
	{
		428001,
		3,
		50,
		"60:1:600"
	},
	{
		428001,
		4,
		75,
		"8:1:500000"
	},
	{
		428001,
		5,
		100,
		"4:400002:20"
	},
	{
		428001,
		6,
		125,
		"60:1:600"
	},
	{
		428001,
		7,
		150,
		"4:36:5"
	},
	{
		428001,
		8,
		175,
		"4:400002:20"
	},
	{
		428001,
		9,
		200,
		"60:1:600"
	},
	{
		428001,
		10,
		225,
		"8:1:500000"
	},
	{
		428001,
		11,
		250,
		"4:400002:20"
	},
	{
		428001,
		12,
		275,
		"60:1:600"
	},
	{
		428001,
		13,
		300,
		"4:36:5"
	},
	{
		428001,
		14,
		325,
		"4:400002:20"
	},
	{
		428001,
		15,
		350,
		"4:510022:5"
	}
}
local t_dsoul_predict_progress_prize = {
	[428001] = {
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

t_dsoul_predict_progress_prize.dataList = dataList

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

return t_dsoul_predict_progress_prize
