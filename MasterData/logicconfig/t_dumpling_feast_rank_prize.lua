-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_rank_prize.lua

module("logicconfig.config.t_dumpling_feast_rank_prize", package.seeall)

local title = {
	prize = 5,
	id = 3,
	title = 4,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		562001,
		{
			1,
			1
		},
		1,
		"第1-10名",
		"13:526:1#104:2:1000#8:1:10000000"
	},
	{
		562001,
		{
			2,
			10
		},
		2,
		"第11-20名",
		"13:526:1#104:2:800#8:1:8000000"
	},
	{
		562001,
		{
			11,
			100
		},
		3,
		"第21-50名",
		"13:526:1#104:2:700#8:1:7000000"
	},
	{
		562001,
		{
			101,
			500
		},
		4,
		"第51-100名",
		"13:526:1#104:2:600#8:1:6000000"
	},
	{
		562001,
		{
			501,
			1000
		},
		5,
		"第501-1000名",
		"13:526:1#104:2:500#8:1:5000000"
	},
	{
		562001,
		{
			1001,
			2000
		},
		6,
		"第1001-2000名",
		"13:526:1#104:2:400#8:1:4000000"
	},
	{
		562001,
		{
			2001,
			5000
		},
		7,
		"第2001-5000名",
		"13:526:1#104:2:200#8:1:2000000"
	}
}
local t_dumpling_feast_rank_prize = {
	[562001] = {
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
			500
		}] = dataList[4],
		[{
			501,
			1000
		}] = dataList[5],
		[{
			1001,
			2000
		}] = dataList[6],
		[{
			2001,
			5000
		}] = dataList[7]
	}
}

t_dumpling_feast_rank_prize.dataList = dataList

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

return t_dumpling_feast_rank_prize
