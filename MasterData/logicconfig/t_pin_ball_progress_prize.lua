-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_ball_progress_prize.lua

module("logicconfig.config.t_pin_ball_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		554001,
		1,
		75,
		"10:556001:25"
	},
	{
		554001,
		2,
		150,
		"10:556001:25"
	},
	{
		554001,
		3,
		225,
		"10:556001:25"
	},
	{
		554001,
		4,
		300,
		"10:556001:25"
	},
	{
		554001,
		5,
		375,
		"10:556001:25"
	},
	{
		554001,
		6,
		450,
		"10:556001:25"
	},
	{
		554002,
		1,
		45,
		"10:453003:200"
	},
	{
		554002,
		2,
		90,
		"10:453003:200"
	},
	{
		554002,
		3,
		135,
		"10:453003:400"
	},
	{
		554002,
		4,
		180,
		"10:453003:400"
	},
	{
		554002,
		5,
		225,
		"10:453003:400"
	},
	{
		554002,
		6,
		270,
		"10:453003:600"
	},
	{
		554002,
		7,
		315,
		"10:453003:600"
	},
	{
		554002,
		8,
		360,
		"10:453003:600"
	},
	{
		554002,
		9,
		405,
		"10:453003:800"
	},
	{
		554002,
		10,
		450,
		"10:453003:800"
	}
}
local t_pin_ball_progress_prize = {
	[554001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[554002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_pin_ball_progress_prize.dataList = dataList

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

return t_pin_ball_progress_prize
