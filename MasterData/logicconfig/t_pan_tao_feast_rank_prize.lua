-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_rank_prize.lua

module("logicconfig.config.t_pan_tao_feast_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		622001,
		1,
		{
			1,
			10
		},
		"1-10名",
		"2:332:1#104:2:1000#8:1:10000000"
	},
	{
		622001,
		2,
		{
			11,
			100
		},
		"11-100名",
		"2:332:1#104:2:800#8:1:8000000"
	},
	{
		622001,
		3,
		{
			101,
			1000
		},
		"101-1000名",
		"2:332:1#104:2:600#8:1:6000000"
	},
	{
		622001,
		4,
		{
			1001,
			3000
		},
		"1001-3000名",
		"2:332:1#104:2:400#8:1:4000000"
	}
}
local t_pan_tao_feast_rank_prize = {
	[622001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_pan_tao_feast_rank_prize.dataList = dataList

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

return t_pan_tao_feast_rank_prize
