-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_rank_prize.lua

module("logicconfig.config.t_draw_and_guess_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 3,
	title = 4,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		536001,
		{
			1,
			10
		},
		1,
		"1~10名",
		"2:265:1#104:2:1000#8:1:1000000"
	},
	{
		536001,
		{
			11,
			100
		},
		2,
		"11~100名",
		"2:265:1#104:2:800#8:1:800000"
	},
	{
		536001,
		{
			101,
			500
		},
		3,
		"101~500名",
		"2:265:1#104:2:600#8:1:600000"
	},
	{
		536001,
		{
			501,
			1500
		},
		4,
		"500~1500名",
		"2:265:1#104:2:400#8:1:400000"
	},
	{
		536001,
		{
			1501,
			3000
		},
		5,
		"1500~3000名",
		"2:265:1#104:2:200#8:1:200000"
	}
}
local t_draw_and_guess_rank_prize = {
	[536001] = {
		[{
			1,
			10
		}] = dataList[1],
		[{
			11,
			100
		}] = dataList[2],
		[{
			101,
			500
		}] = dataList[3],
		[{
			501,
			1500
		}] = dataList[4],
		[{
			1501,
			3000
		}] = dataList[5]
	}
}

t_draw_and_guess_rank_prize.dataList = dataList

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

return t_draw_and_guess_rank_prize
