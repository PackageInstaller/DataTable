-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_against_landlords_rank_prize.lua

module("logicconfig.config.t_fight_against_landlords_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		243006,
		{
			1,
			1
		},
		"1名",
		"2:248:1#1:300078:-1:1#104:2:1000"
	},
	{
		243006,
		{
			2,
			5
		},
		"2~5名",
		"2:248:1#1:300078:-1:1#104:2:800"
	},
	{
		243006,
		{
			6,
			20
		},
		"6~20名",
		"2:248:1#1:300078:-1:1#104:2:600"
	},
	{
		243006,
		{
			21,
			50
		},
		"21~50名",
		"2:248:1#1:300078:-1:1#104:2:400"
	},
	{
		243006,
		{
			51,
			100
		},
		"51~100名",
		"2:248:1#1:300078:-1:1#104:2:200"
	},
	{
		243006,
		{
			101,
			500
		},
		"101~500名",
		"2:248:1#1:300078:-1:1#104:2:100"
	},
	{
		243006,
		{
			501,
			1000
		},
		"501~1000名",
		"2:248:1#1:300078:-1:1"
	},
	{
		243007,
		{
			1,
			1
		},
		"1名",
		"104:2:1000#8:1:2000000"
	},
	{
		243007,
		{
			2,
			5
		},
		"2~5名",
		"104:2:800#8:1:1800000"
	},
	{
		243007,
		{
			6,
			20
		},
		"6~20名",
		"104:2:600#8:1:1500000"
	},
	{
		243007,
		{
			21,
			50
		},
		"21~50名",
		"104:2:400#8:1:1200000"
	},
	{
		243007,
		{
			51,
			100
		},
		"51~100名",
		"104:2:200#8:1:1000000"
	},
	{
		243007,
		{
			101,
			500
		},
		"101~500名",
		"104:2:100#8:1:800000"
	},
	{
		243007,
		{
			501,
			1000
		},
		"501~1000名",
		"104:2:50#8:1:500000"
	}
}
local t_fight_against_landlords_rank_prize = {
	[243006] = {
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
	[243007] = {
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
		}] = dataList[14]
	}
}

t_fight_against_landlords_rank_prize.dataList = dataList

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

return t_fight_against_landlords_rank_prize
