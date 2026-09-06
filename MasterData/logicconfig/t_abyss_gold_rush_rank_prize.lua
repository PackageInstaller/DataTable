-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_rank_prize.lua

module("logicconfig.config.t_abyss_gold_rush_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		612001,
		{
			1,
			10
		},
		"第1-10名",
		"2:328:1#104:2:1000#8:1:10000000"
	},
	{
		612001,
		{
			11,
			20
		},
		"第11-20名",
		"2:328:1#104:2:800#8:1:8000000"
	},
	{
		612001,
		{
			21,
			50
		},
		"第21-50名",
		"2:328:1#104:2:700#8:1:7000000"
	},
	{
		612001,
		{
			51,
			100
		},
		"第51-100名",
		"2:328:1#104:2:600#8:1:6000000"
	},
	{
		612001,
		{
			101,
			300
		},
		"第101-300名",
		"2:328:1#104:2:500#8:1:5000000"
	},
	{
		612001,
		{
			301,
			500
		},
		"第301-500名",
		"2:328:1#104:2:400#8:1:4000000"
	},
	{
		612001,
		{
			501,
			1000
		},
		"第501-1000名",
		"2:328:1#104:2:300#8:1:3000000"
	},
	{
		612001,
		{
			1001,
			2000
		},
		"第1001-2000名",
		"2:328:1#104:2:200#8:1:2000000"
	}
}
local t_abyss_gold_rush_rank_prize = {
	[612001] = {
		[{
			1,
			10
		}] = dataList[1],
		[{
			11,
			20
		}] = dataList[2],
		[{
			21,
			50
		}] = dataList[3],
		[{
			51,
			100
		}] = dataList[4],
		[{
			101,
			300
		}] = dataList[5],
		[{
			301,
			500
		}] = dataList[6],
		[{
			501,
			1000
		}] = dataList[7],
		[{
			1001,
			2000
		}] = dataList[8]
	}
}

t_abyss_gold_rush_rank_prize.dataList = dataList

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

return t_abyss_gold_rush_rank_prize
