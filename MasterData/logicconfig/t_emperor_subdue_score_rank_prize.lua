-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_emperor_subdue_score_rank_prize.lua

module("logicconfig.config.t_emperor_subdue_score_rank_prize", package.seeall)

local title = {
	prize = 5,
	id = 3,
	title = 4,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		547001,
		{
			1,
			1
		},
		1,
		"1名",
		"2:275:1#104:2:1000#8:1:10000000"
	},
	{
		547001,
		{
			2,
			5
		},
		2,
		"2~5名",
		"2:275:1#104:2:800#8:1:8000000"
	},
	{
		547001,
		{
			6,
			20
		},
		3,
		"6~20名",
		"2:275:1#104:2:700#8:1:7000000"
	},
	{
		547001,
		{
			21,
			50
		},
		4,
		"21~50名",
		"2:275:1#104:2:600#8:1:6000000"
	},
	{
		547001,
		{
			51,
			100
		},
		5,
		"51~100名",
		"2:275:1#104:2:500#8:1:5000000"
	},
	{
		547001,
		{
			101,
			500
		},
		6,
		"101~500名",
		"2:275:1#104:2:400#8:1:4000000"
	},
	{
		547001,
		{
			501,
			1000
		},
		7,
		"501~1000名",
		"2:275:1#104:2:300#8:1:3000000"
	},
	{
		547001,
		{
			1001,
			3000
		},
		8,
		"<color=#FF2929FF>第1001-3000名",
		"2:275:1#104:2:200#8:1:2000000"
	}
}
local t_emperor_subdue_score_rank_prize = {
	[547001] = {
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
		}] = dataList[7],
		[{
			1001,
			3000
		}] = dataList[8]
	}
}

t_emperor_subdue_score_rank_prize.dataList = dataList

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

return t_emperor_subdue_score_rank_prize
