-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_red_pack_rank_prize.lua

module("logicconfig.config.t_goddess_competition_red_pack_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		453001,
		{
			1,
			1
		},
		"1名",
		"1:300061:-1:1#2:214:1#104:2:15000#4:147:1"
	},
	{
		453001,
		{
			2,
			10
		},
		"2~10名",
		"1:300061:-1:1#2:214:1#104:2:10000#4:147:1"
	},
	{
		453001,
		{
			11,
			100
		},
		"11~100名",
		"1:300061:-1:1#2:214:1#104:2:8000#4:109:1"
	},
	{
		453001,
		{
			101,
			500
		},
		"101~500名",
		"1:300061:-1:1#2:214:1#104:2:6000#4:108:1"
	},
	{
		453001,
		{
			501,
			1000
		},
		"501~1000名",
		"2:214:1#104:2:5000#4:108:1"
	},
	{
		453002,
		{
			1,
			1
		},
		"1名",
		"1:300101:-1:1#2:292:1#104:2:15000#4:147:1"
	},
	{
		453002,
		{
			2,
			10
		},
		"2~10名",
		"1:300101:-1:1#2:292:1#104:2:10000#4:147:1"
	},
	{
		453002,
		{
			11,
			100
		},
		"11~100名",
		"1:300101:-1:1#2:292:1#104:2:8000#4:109:1"
	},
	{
		453002,
		{
			101,
			500
		},
		"101~500名",
		"1:300101:-1:1#2:292:1#104:2:6000#4:108:1"
	},
	{
		453002,
		{
			501,
			1000
		},
		"501~1000名",
		"2:292:1#104:2:5000#4:108:1"
	}
}
local t_goddess_competition_red_pack_rank_prize = {
	[453001] = {
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
		}] = dataList[5]
	},
	[453002] = {
		[{
			1,
			1
		}] = dataList[6],
		[{
			2,
			10
		}] = dataList[7],
		[{
			11,
			100
		}] = dataList[8],
		[{
			101,
			500
		}] = dataList[9],
		[{
			501,
			1000
		}] = dataList[10]
	}
}

t_goddess_competition_red_pack_rank_prize.dataList = dataList

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

return t_goddess_competition_red_pack_rank_prize
