-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_weileita_normal_progress_prize.lua

module("logicconfig.config.t_origin_weileita_normal_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		561001,
		1,
		5,
		"8:1:1000000"
	},
	{
		561001,
		2,
		10,
		"4:437:5"
	},
	{
		561001,
		3,
		15,
		"4:437:5"
	},
	{
		561001,
		4,
		20,
		"4:437:10"
	},
	{
		561001,
		5,
		25,
		"4:90004:1"
	},
	{
		561001,
		6,
		30,
		"4:30006:20"
	},
	{
		561001,
		7,
		35,
		"4:30006:20"
	}
}
local t_origin_weileita_normal_progress_prize = {
	[561001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_origin_weileita_normal_progress_prize.dataList = dataList

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

return t_origin_weileita_normal_progress_prize
