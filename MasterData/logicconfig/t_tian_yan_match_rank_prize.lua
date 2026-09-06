-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_yan_match_rank_prize.lua

module("logicconfig.config.t_tian_yan_match_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		503001,
		{
			1,
			1
		},
		"第1名",
		"2:252:1#104:2:1000#8:1:10000000"
	},
	{
		503001,
		{
			2,
			2
		},
		"第2名",
		"2:252:1#104:2:800#8:1:8000000"
	},
	{
		503001,
		{
			3,
			3
		},
		"第3名",
		"2:252:1#104:2:700#8:1:7000000"
	},
	{
		503001,
		{
			4,
			10
		},
		"4-10名",
		"2:252:1#104:2:600#8:1:6000000"
	},
	{
		503001,
		{
			11,
			100
		},
		"11-100名",
		"2:252:1#104:2:600#8:1:5000000"
	},
	{
		503001,
		{
			101,
			200
		},
		"101-200名",
		"2:252:1#104:2:500#8:1:5000000"
	},
	{
		503001,
		{
			201,
			300
		},
		"201-300名",
		"2:252:1#104:2:400#8:1:4000000"
	},
	{
		503001,
		{
			301,
			500
		},
		"301-500名",
		"2:252:1#104:2:300#8:1:3000000"
	},
	{
		503001,
		{
			501,
			1000
		},
		"501-1000名",
		"2:252:1#104:2:200#8:1:2000000"
	},
	{
		503001,
		{
			1001,
			3000
		},
		"1001-3000名",
		"2:252:1#104:2:100#8:1:1000000"
	}
}
local t_tian_yan_match_rank_prize = {
	[503001] = {
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
			10
		}] = dataList[4],
		[{
			11,
			100
		}] = dataList[5],
		[{
			101,
			200
		}] = dataList[6],
		[{
			201,
			300
		}] = dataList[7],
		[{
			301,
			500
		}] = dataList[8],
		[{
			501,
			1000
		}] = dataList[9],
		[{
			1001,
			3000
		}] = dataList[10]
	}
}

t_tian_yan_match_rank_prize.dataList = dataList

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

return t_tian_yan_match_rank_prize
