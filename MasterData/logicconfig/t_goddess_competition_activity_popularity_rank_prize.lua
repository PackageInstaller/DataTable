-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_activity_popularity_rank_prize.lua

module("logicconfig.config.t_goddess_competition_activity_popularity_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		453002,
		{
			1,
			1
		},
		"1名",
		"1:500032:-1:1#4:90527:1#2:287:1#2:291:1#10:453008:1#4:410001:1#4:147:1#104:2:2000#8:1:1000000"
	},
	{
		453002,
		{
			2,
			2
		},
		"2名",
		"1:500033:-1:1#4:90527:1#2:288:1#2:291:1#10:453008:1#4:410001:1#4:147:1#104:2:2000#8:1:1000000"
	},
	{
		453002,
		{
			3,
			3
		},
		"3名",
		"1:500034:-1:1#4:90527:1#2:288:1#2:291:1#10:453008:1#4:410001:1#4:147:1#104:2:2000#8:1:1000000"
	},
	{
		453002,
		{
			4,
			4
		},
		"4名",
		"1:500035:-1:1#4:90527:1#2:288:1#2:291:1#10:453008:1#4:410001:1#4:147:1#104:2:2000#8:1:1000000"
	},
	{
		453002,
		{
			5,
			10
		},
		"5~10名",
		"4:90527:1#2:289:1#2:291:1#4:410001:1#4:147:1#104:2:1500#8:1:1000000"
	},
	{
		453002,
		{
			11,
			20
		},
		"11~20名",
		"4:90527:1#2:290:1#2:291:1#4:410001:1#4:147:1#104:2:1000#8:1:1000000"
	},
	{
		453002,
		{
			21,
			100
		},
		"21~100名",
		"2:291:1#4:410009:1#4:109:1#104:2:1000#8:1:800000"
	},
	{
		453002,
		{
			101,
			500
		},
		"101~500名",
		"2:291:1#4:410009:1#4:108:1#104:2:800#8:1:800000"
	},
	{
		453002,
		{
			501,
			1000
		},
		"501~1000名",
		"2:291:1#4:410002:1#4:108:1#104:2:500#8:1:500000"
	},
	{
		453002,
		{
			1001,
			5000
		},
		"1001~5000名",
		"2:291:1#4:400004:25#4:108:1#104:2:500#8:1:500000"
	}
}
local t_goddess_competition_activity_popularity_rank_prize = {
	[453002] = {
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
			4
		}] = dataList[4],
		[{
			5,
			10
		}] = dataList[5],
		[{
			11,
			20
		}] = dataList[6],
		[{
			21,
			100
		}] = dataList[7],
		[{
			101,
			500
		}] = dataList[8],
		[{
			501,
			1000
		}] = dataList[9],
		[{
			1001,
			5000
		}] = dataList[10]
	}
}

t_goddess_competition_activity_popularity_rank_prize.dataList = dataList

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

return t_goddess_competition_activity_popularity_rank_prize
