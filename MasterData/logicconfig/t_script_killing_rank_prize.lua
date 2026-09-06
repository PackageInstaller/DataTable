-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_rank_prize.lua

module("logicconfig.config.t_script_killing_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		365001,
		{
			1,
			1
		},
		"1名",
		"2:166:1#104:2:2000#8:1:2000000"
	},
	{
		365001,
		{
			2,
			5
		},
		"2~5名",
		"2:166:1#104:2:1500#8:1:1600000"
	},
	{
		365001,
		{
			6,
			20
		},
		"6~20名",
		"2:166:1#104:2:1000#8:1:1200000"
	},
	{
		365001,
		{
			21,
			50
		},
		"21~50名",
		"2:166:1#104:2:800#8:1:1000000"
	},
	{
		365001,
		{
			51,
			100
		},
		"51~100名",
		"2:166:1#104:2:600#8:1:800000"
	},
	{
		365001,
		{
			101,
			500
		},
		"101~500名",
		"2:166:1#104:2:400#8:1:600000"
	},
	{
		365001,
		{
			501,
			1000
		},
		"501~1000名",
		"2:166:1#104:2:200#8:1:400000"
	},
	{
		365003,
		{
			1,
			100
		},
		"1-100名",
		"2:334:1#104:2:1000#8:1:1000000"
	},
	{
		365003,
		{
			101,
			500
		},
		"101-500名",
		"2:334:1#104:2:800#8:1:800000"
	},
	{
		365003,
		{
			501,
			1000
		},
		"501-1000名",
		"2:334:1#104:2:600#8:1:600000"
	},
	{
		365003,
		{
			1001,
			3000
		},
		"1001-3000名",
		"2:334:1#104:2:400#8:1:400000"
	},
	{
		365003,
		{
			3001,
			5000
		},
		"3001-5000名",
		"2:334:1#104:2:200#8:1:200000"
	}
}
local t_script_killing_rank_prize = {
	[365001] = {
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
	[365003] = {
		[{
			1,
			100
		}] = dataList[8],
		[{
			101,
			500
		}] = dataList[9],
		[{
			501,
			1000
		}] = dataList[10],
		[{
			1001,
			3000
		}] = dataList[11],
		[{
			3001,
			5000
		}] = dataList[12]
	}
}

t_script_killing_rank_prize.dataList = dataList

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

return t_script_killing_rank_prize
