-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_step_popularity_rank_prize.lua

module("logicconfig.config.t_goddess_competition_step_popularity_rank_prize", package.seeall)

local title = {
	prize = 5,
	stepId = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		453002,
		1,
		{
			1,
			1
		},
		"1名",
		"4:510243:5#104:2:1500#4:147:1#8:1:1000000"
	},
	{
		453002,
		1,
		{
			2,
			10
		},
		"2~10名",
		"4:510243:4#104:2:1000#4:147:1#8:1:900000"
	},
	{
		453002,
		1,
		{
			11,
			100
		},
		"11~100名",
		"4:510243:3#104:2:800#4:109:1#8:1:800000"
	},
	{
		453002,
		1,
		{
			101,
			500
		},
		"101~500名",
		"4:510243:2#104:2:600#4:108:1#8:1:700000"
	},
	{
		453002,
		1,
		{
			501,
			1000
		},
		"501~1000名",
		"4:510243:2#104:2:500#4:108:1#8:1:600000"
	},
	{
		453002,
		2,
		{
			1,
			1
		},
		"1名",
		"4:510243:5#104:2:1500#4:147:1#8:1:1000000"
	},
	{
		453002,
		2,
		{
			2,
			10
		},
		"2~10名",
		"4:510243:4#104:2:1000#4:147:1#8:1:900000"
	},
	{
		453002,
		2,
		{
			11,
			100
		},
		"11~100名",
		"4:510243:3#104:2:800#4:109:1#8:1:800000"
	},
	{
		453002,
		2,
		{
			101,
			500
		},
		"101~500名",
		"4:510243:2#104:2:600#4:108:1#8:1:700000"
	},
	{
		453002,
		2,
		{
			501,
			1000
		},
		"501~1000名",
		"4:510243:2#104:2:500#4:108:1#8:1:600000"
	},
	{
		453002,
		3,
		{
			1,
			1
		},
		"1名",
		"4:510243:5#104:2:1500#4:147:1#8:1:1000000"
	},
	{
		453002,
		3,
		{
			2,
			10
		},
		"2~10名",
		"4:510243:4#104:2:1000#4:147:1#8:1:900000"
	},
	{
		453002,
		3,
		{
			11,
			100
		},
		"11~100名",
		"4:510243:3#104:2:800#4:109:1#8:1:800000"
	},
	{
		453002,
		3,
		{
			101,
			500
		},
		"101~500名",
		"4:510243:2#104:2:600#4:108:1#8:1:700000"
	},
	{
		453002,
		3,
		{
			501,
			1000
		},
		"501~1000名",
		"4:510243:2#104:2:500#4:108:1#8:1:600000"
	}
}
local t_goddess_competition_step_popularity_rank_prize = {
	[453002] = {
		{
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
		{
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
		},
		{
			[{
				1,
				1
			}] = dataList[11],
			[{
				2,
				10
			}] = dataList[12],
			[{
				11,
				100
			}] = dataList[13],
			[{
				101,
				500
			}] = dataList[14],
			[{
				501,
				1000
			}] = dataList[15]
		}
	}
}

t_goddess_competition_step_popularity_rank_prize.dataList = dataList

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

return t_goddess_competition_step_popularity_rank_prize
