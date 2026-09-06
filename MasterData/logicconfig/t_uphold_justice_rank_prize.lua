-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_uphold_justice_rank_prize.lua

module("logicconfig.config.t_uphold_justice_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		581001,
		{
			1,
			1
		},
		"1名",
		"2:293:1#104:2:1000#8:1:2000000"
	},
	{
		581001,
		{
			2,
			10
		},
		"2~10名",
		"2:293:1#104:2:800#8:1:1600000"
	},
	{
		581001,
		{
			11,
			100
		},
		"11~100名",
		"2:293:1#104:2:600#8:1:1200000"
	},
	{
		581001,
		{
			101,
			1000
		},
		"101~1000名",
		"2:293:1#104:2:400#8:1:1000000"
	},
	{
		581001,
		{
			1001,
			3000
		},
		"1001~3000名",
		"2:293:1#104:2:300#8:1:800000"
	},
	{
		581001,
		{
			3001,
			5000
		},
		"3001~5000名",
		"2:293:1#104:2:300#8:1:600000"
	},
	{
		581001,
		{
			5001,
			10000
		},
		"5001~10000名",
		"2:293:1#104:2:200#8:1:400000"
	}
}
local t_uphold_justice_rank_prize = {
	[581001] = {
		[{
			1,
			1
		}] = dataList[1],
		[{
			2,
			10
		}] = dataList[2],
		[{
			11,
			100
		}] = dataList[3],
		[{
			101,
			1000
		}] = dataList[4],
		[{
			1001,
			3000
		}] = dataList[5],
		[{
			3001,
			5000
		}] = dataList[6],
		[{
			5001,
			10000
		}] = dataList[7]
	}
}

t_uphold_justice_rank_prize.dataList = dataList

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

return t_uphold_justice_rank_prize
