-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_city_rank_prize.lua

module("logicconfig.config.t_eternal_city_rank_prize", package.seeall)

local title = {
	prize = 5,
	id = 3,
	title = 4,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		557001,
		{
			1,
			10
		},
		1,
		"第1-10名",
		"2:274:1#1:300095:-1:1#104:2:1000"
	},
	{
		557001,
		{
			11,
			20
		},
		2,
		"第11-20名",
		"2:274:1#1:300095:-1:1#104:2:800"
	},
	{
		557001,
		{
			21,
			50
		},
		3,
		"第21-50名",
		"2:274:1#1:300095:-1:1#104:2:700"
	},
	{
		557001,
		{
			51,
			100
		},
		4,
		"第51-100名",
		"2:274:1#1:300095:-1:1#104:2:600"
	},
	{
		557001,
		{
			101,
			300
		},
		5,
		"第101-300名",
		"2:274:1#1:300095:-1:1#104:2:500"
	},
	{
		557001,
		{
			301,
			500
		},
		6,
		"第301-500名",
		"2:274:1#1:300095:-1:1#104:2:400"
	},
	{
		557001,
		{
			501,
			1000
		},
		7,
		"第501-1000名",
		"2:274:1#1:300095:-1:1#104:2:300"
	},
	{
		557001,
		{
			1001,
			2000
		},
		8,
		"第1001-2000名",
		"2:274:1#1:300095:-1:1#104:2:200"
	},
	{
		557001,
		{
			2001,
			3000
		},
		9,
		"第2001-3000名",
		"2:274:1#104:2:200"
	}
}
local t_eternal_city_rank_prize = {
	[557001] = {
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
		}] = dataList[8],
		[{
			2001,
			3000
		}] = dataList[9]
	}
}

t_eternal_city_rank_prize.dataList = dataList

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

return t_eternal_city_rank_prize
