-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter2_boss_rank_prize.lua

module("logicconfig.config.t_luyngarde_chapter2_boss_rank_prize", package.seeall)

local title = {
	title = 4,
	prize = 5,
	typeId = 2,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		466001,
		1,
		{
			1,
			1
		},
		"1名",
		"2:229:1#104:2:2000"
	},
	{
		466001,
		1,
		{
			2,
			5
		},
		"2~5名",
		"2:229:1#104:2:1500"
	},
	{
		466001,
		1,
		{
			6,
			20
		},
		"6~20名",
		"2:229:1#104:2:1200"
	},
	{
		466001,
		1,
		{
			21,
			50
		},
		"21~50名",
		"2:229:1#104:2:1000"
	},
	{
		466001,
		1,
		{
			51,
			100
		},
		"51~100名",
		"2:229:1#104:2:800"
	},
	{
		466001,
		1,
		{
			101,
			500
		},
		"101~500名",
		"2:229:1#104:2:500"
	},
	{
		466001,
		1,
		{
			501,
			1000
		},
		"501~1000名",
		"2:229:1#104:2:300"
	},
	{
		466001,
		2,
		{
			1,
			1
		},
		"1名",
		"104:2:1000#8:1:1000000"
	},
	{
		466001,
		2,
		{
			2,
			5
		},
		"2~5名",
		"104:2:800#8:1:1000000"
	},
	{
		466001,
		2,
		{
			6,
			20
		},
		"6~20名",
		"104:2:600#8:1:1000000"
	},
	{
		466001,
		2,
		{
			21,
			50
		},
		"21~50名",
		"104:2:400#8:1:1000000"
	},
	{
		466001,
		2,
		{
			51,
			100
		},
		"51~100名",
		"104:2:200#8:1:1000000"
	},
	{
		466001,
		2,
		{
			101,
			500
		},
		"101~500名",
		"104:2:100#8:1:1000000"
	},
	{
		466001,
		2,
		{
			501,
			1000
		},
		"501~1000名",
		"104:2:50#8:1:1000000"
	},
	{
		466001,
		2,
		{
			1001,
			5000
		},
		"1001~5000名",
		"8:1:1000000"
	}
}
local t_luyngarde_chapter2_boss_rank_prize = {
	[466001] = {
		{
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
				500
			}] = dataList[6],
			[{
				501,
				1000
			}] = dataList[7]
		},
		{
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
				500
			}] = dataList[13],
			[{
				501,
				1000
			}] = dataList[14],
			[{
				1001,
				5000
			}] = dataList[15]
		}
	}
}

t_luyngarde_chapter2_boss_rank_prize.dataList = dataList

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

return t_luyngarde_chapter2_boss_rank_prize
