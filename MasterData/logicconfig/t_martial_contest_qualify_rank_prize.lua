-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_qualify_rank_prize.lua

module("logicconfig.config.t_martial_contest_qualify_rank_prize", package.seeall)

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
		"1:300108:-1:1#104:2:1000#8:1:2500000"
	},
	{
		583001,
		{
			2,
			2
		},
		"第2名",
		"1:300108:-1:1#104:2:800#8:1:2000000"
	},
	{
		583001,
		{
			3,
			3
		},
		"第3名",
		"1:300108:-1:1#104:2:700#8:1:1750000"
	},
	{
		583001,
		{
			4,
			20
		},
		"4-20名",
		"1:300108:-1:1#104:2:600#8:1:1500000"
	},
	{
		583001,
		{
			21,
			50
		},
		"21-50名",
		"1:300108:-1:1#104:2:500#8:1:1250000"
	},
	{
		583001,
		{
			51,
			100
		},
		"51-100名",
		"1:300108:-1:1#104:2:400#8:1:1000000"
	},
	{
		583001,
		{
			101,
			250
		},
		"101-250名",
		"1:300108:-1:1#104:2:300#8:1:750000"
	},
	{
		583001,
		{
			251,
			500
		},
		"251-500名",
		"1:300108:-1:1#104:2:200#8:1:500000"
	}
}
local t_martial_contest_qualify_rank_prize = {
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
			50
		}] = dataList[5],
		[{
			51,
			100
		}] = dataList[6],
		[{
			101,
			250
		}] = dataList[7],
		[{
			251,
			500
		}] = dataList[8]
	}
}

t_martial_contest_qualify_rank_prize.dataList = dataList

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

return t_martial_contest_qualify_rank_prize
