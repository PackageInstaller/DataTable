-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_stage_rank_prize.lua

module("logicconfig.config.t_saint_knight_expedition_stage_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		481001,
		1,
		{
			1,
			1
		},
		"1名",
		"2:235:1#104:2:1000#8:1:1000000"
	},
	{
		481001,
		2,
		{
			2,
			10
		},
		"2~10名",
		"2:235:1#104:2:800#8:1:800000"
	},
	{
		481001,
		3,
		{
			11,
			100
		},
		"11~100名",
		"2:235:1#104:2:600#8:1:600000"
	},
	{
		481001,
		4,
		{
			101,
			500
		},
		"101~500名",
		"2:235:1#104:2:400#8:1:400000"
	},
	{
		481001,
		5,
		{
			501,
			1000
		},
		"501~1000名",
		"2:235:1#104:2:200#8:1:200000"
	}
}
local t_saint_knight_expedition_stage_rank_prize = {
	[481001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_saint_knight_expedition_stage_rank_prize.dataList = dataList

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

return t_saint_knight_expedition_stage_rank_prize
