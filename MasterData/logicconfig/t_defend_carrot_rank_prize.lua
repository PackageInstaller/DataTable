-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_rank_prize.lua

module("logicconfig.config.t_defend_carrot_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		517001,
		{
			1,
			1
		},
		"1名",
		"1:300084:-1:1#104:2:1000#8:1:2500000"
	},
	{
		517001,
		{
			2,
			5
		},
		"2~5名",
		"1:300084:-1:1#104:2:800#8:1:2000000"
	},
	{
		517001,
		{
			6,
			20
		},
		"6~20名",
		"1:300084:-1:1#104:2:600#8:1:1500000"
	},
	{
		517001,
		{
			21,
			50
		},
		"21~50名",
		"1:300084:-1:1#104:2:500#8:1:1000000"
	},
	{
		517001,
		{
			51,
			100
		},
		"51~100名",
		"1:300084:-1:1#104:2:400#8:1:800000"
	},
	{
		517001,
		{
			101,
			500
		},
		"101~500名",
		"1:300084:-1:1#104:2:300#8:1:600000"
	},
	{
		517001,
		{
			501,
			1000
		},
		"501~1000名",
		"1:300084:-1:1#104:2:200#8:1:400000"
	},
	{
		517001,
		{
			1001,
			3000
		},
		"1001~3000名",
		"1:300084:-1:1#104:2:100#8:1:200000"
	}
}
local t_defend_carrot_rank_prize = {
	[517001] = {
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

t_defend_carrot_rank_prize.dataList = dataList

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

return t_defend_carrot_rank_prize
