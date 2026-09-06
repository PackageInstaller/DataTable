-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_rank_prize.lua

module("logicconfig.config.t_survival_king_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 3,
	title = 4,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		529001,
		{
			1,
			10
		},
		1,
		"1名",
		"1:300086:-1:1#2:262:1#104:2:1000#8:1:10000000"
	},
	{
		529001,
		{
			11,
			100
		},
		3,
		"11~100名",
		"1:300086:-1:1#2:262:1#104:2:800#8:1:8000000"
	},
	{
		529001,
		{
			101,
			500
		},
		4,
		"101~500名",
		"1:300086:-1:1#2:262:1#104:2:600#8:1:6000000"
	},
	{
		529001,
		{
			501,
			1500
		},
		5,
		"501~1500名",
		"1:300086:-1:1#2:262:1#104:2:400#8:1:4000000"
	},
	{
		529001,
		{
			1501,
			3000
		},
		6,
		"1501~3000名",
		"2:262:1#104:2:200#8:1:2000000"
	},
	{
		529002,
		{
			1,
			10
		},
		1,
		"1名",
		"2:333:1#104:2:1000#8:1:10000000"
	},
	{
		529002,
		{
			11,
			100
		},
		3,
		"11~100名",
		"2:333:1#104:2:800#8:1:8000000"
	},
	{
		529002,
		{
			101,
			500
		},
		4,
		"101~500名",
		"2:333:1#104:2:600#8:1:6000000"
	},
	{
		529002,
		{
			501,
			1500
		},
		5,
		"501~1500名",
		"2:333:1#104:2:400#8:1:4000000"
	},
	{
		529002,
		{
			1501,
			3000
		},
		6,
		"1501~3000名",
		"2:333:1#104:2:200#8:1:2000000"
	}
}
local t_survival_king_rank_prize = {
	[529001] = {
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
	},
	[529002] = {
		[{
			1,
			10
		}] = dataList[6],
		[{
			11,
			100
		}] = dataList[7],
		[{
			101,
			500
		}] = dataList[8],
		[{
			501,
			1500
		}] = dataList[9],
		[{
			1501,
			3000
		}] = dataList[10]
	}
}

t_survival_king_rank_prize.dataList = dataList

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

return t_survival_king_rank_prize
