-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_kaya_normal_progress_prize.lua

module("logicconfig.config.t_king_kaya_normal_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		371001,
		1,
		50,
		"4:90004:1"
	},
	{
		371001,
		2,
		100,
		"4:236:5"
	},
	{
		371001,
		3,
		200,
		"8:1:1000000"
	},
	{
		371001,
		4,
		300,
		"4:236:5"
	},
	{
		371001,
		5,
		400,
		"4:236:10"
	},
	{
		371002,
		1,
		50,
		"8:1:1"
	},
	{
		371002,
		2,
		100,
		"8:1:1"
	},
	{
		371002,
		3,
		200,
		"8:1:1"
	},
	{
		371002,
		4,
		300,
		"8:1:1"
	},
	{
		371002,
		5,
		400,
		"8:1:1"
	}
}
local t_king_kaya_normal_progress_prize = {
	[371001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[371002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_king_kaya_normal_progress_prize.dataList = dataList

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

return t_king_kaya_normal_progress_prize
