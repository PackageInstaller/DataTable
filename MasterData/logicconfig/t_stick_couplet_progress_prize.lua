-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_stick_couplet_progress_prize.lua

module("logicconfig.config.t_stick_couplet_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1,
	needScore = 4
}
local dataList = {
	{
		439001,
		1,
		"60:1:500",
		100
	},
	{
		439001,
		2,
		"4:31:5",
		150
	},
	{
		439001,
		3,
		"60:1:500",
		200
	},
	{
		439001,
		4,
		"8:1:1000000",
		250
	},
	{
		439001,
		5,
		"60:1:500",
		300
	},
	{
		439001,
		6,
		"4:31:5",
		350
	},
	{
		439001,
		7,
		"60:1:500",
		400
	},
	{
		439001,
		8,
		"8:1:1000000",
		450
	},
	{
		439001,
		9,
		"60:1:500",
		500
	},
	{
		439001,
		10,
		"8:1:1000000",
		600
	},
	{
		439001,
		11,
		"60:1:500",
		700
	}
}
local t_stick_couplet_progress_prize = {
	[439001] = {
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
		dataList[11]
	}
}

t_stick_couplet_progress_prize.dataList = dataList

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

return t_stick_couplet_progress_prize
