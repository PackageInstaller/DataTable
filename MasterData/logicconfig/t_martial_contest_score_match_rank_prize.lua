-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_score_match_rank_prize.lua

module("logicconfig.config.t_martial_contest_score_match_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		583001,
		{
			1,
			1
		},
		"第1名",
		"104:2:1000#8:1:2500000"
	},
	{
		583001,
		{
			2,
			2
		},
		"第2名",
		"104:2:800#8:1:2000000"
	},
	{
		583001,
		{
			3,
			3
		},
		"第3名",
		"104:2:700#8:1:1750000"
	},
	{
		583001,
		{
			4,
			20
		},
		"4-20名",
		"104:2:600#8:1:1500000"
	},
	{
		583001,
		{
			21,
			40
		},
		"21-40名",
		"104:2:500#8:1:1250000"
	},
	{
		583001,
		{
			41,
			80
		},
		"41-80名",
		"104:2:400#8:1:1000000"
	},
	{
		583001,
		{
			81,
			160
		},
		"81-160名",
		"104:2:300#8:1:750000"
	},
	{
		583001,
		{
			161,
			320
		},
		"161-320名",
		"104:2:200#8:1:500000"
	}
}
local t_martial_contest_score_match_rank_prize = {
	[583001] = {
		[{
			1,
			1
		}] = dataList[1],
		[{
			2,
			2
		}] = dataList[2],
		[{
			3,
			3
		}] = dataList[3],
		[{
			4,
			20
		}] = dataList[4],
		[{
			21,
			40
		}] = dataList[5],
		[{
			41,
			80
		}] = dataList[6],
		[{
			81,
			160
		}] = dataList[7],
		[{
			161,
			320
		}] = dataList[8]
	}
}

t_martial_contest_score_match_rank_prize.dataList = dataList

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

return t_martial_contest_score_match_rank_prize
