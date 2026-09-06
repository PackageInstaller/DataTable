-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_rank_prize.lua

module("logicconfig.config.t_dragon_awaken_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		419001,
		{
			1,
			1
		},
		"1名",
		"2:203:1#104:2:1000#8:1:1000000"
	},
	{
		419001,
		{
			2,
			5
		},
		"2~5名",
		"2:203:1#104:2:900#8:1:900000"
	},
	{
		419001,
		{
			6,
			20
		},
		"6~20名",
		"2:203:1#104:2:800#8:1:800000"
	},
	{
		419001,
		{
			21,
			50
		},
		"21~50名",
		"2:203:1#104:2:700#8:1:700000"
	},
	{
		419001,
		{
			51,
			100
		},
		"51~100名",
		"2:203:1#104:2:600#8:1:600000"
	},
	{
		419001,
		{
			101,
			1000
		},
		"101~500名",
		"2:203:1#104:2:400#8:1:400000"
	},
	{
		419001,
		{
			1001,
			10000
		},
		"501~1000名",
		"2:203:1#104:2:200#8:1:200000"
	},
	{
		419002,
		{
			1,
			1
		},
		"1名",
		"104:2:1000#8:1:1000000"
	},
	{
		419002,
		{
			2,
			5
		},
		"2~5名",
		"104:2:900#8:1:900000"
	},
	{
		419002,
		{
			6,
			20
		},
		"6~20名",
		"104:2:800#8:1:800000"
	},
	{
		419002,
		{
			21,
			50
		},
		"21~50名",
		"104:2:700#8:1:700000"
	},
	{
		419002,
		{
			51,
			100
		},
		"51~100名",
		"104:2:600#8:1:600000"
	},
	{
		419002,
		{
			101,
			1000
		},
		"101~500名",
		"104:2:400#8:1:400000"
	},
	{
		419002,
		{
			1001,
			10000
		},
		"501~1000名",
		"104:2:200#8:1:200000"
	}
}
local t_dragon_awaken_rank_prize = {
	[419001] = {
		[{
			1,
			1
		}] = dataList[1],
		[{
			2,
			5
		}] = dataList[2],
		[{
			6,
			20
		}] = dataList[3],
		[{
			21,
			50
		}] = dataList[4],
		[{
			51,
			100
		}] = dataList[5],
		[{
			101,
			1000
		}] = dataList[6],
		[{
			1001,
			10000
		}] = dataList[7]
	},
	[419002] = {
		[{
			1,
			1
		}] = dataList[8],
		[{
			2,
			5
		}] = dataList[9],
		[{
			6,
			20
		}] = dataList[10],
		[{
			21,
			50
		}] = dataList[11],
		[{
			51,
			100
		}] = dataList[12],
		[{
			101,
			1000
		}] = dataList[13],
		[{
			1001,
			10000
		}] = dataList[14]
	}
}

t_dragon_awaken_rank_prize.dataList = dataList

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

return t_dragon_awaken_rank_prize
