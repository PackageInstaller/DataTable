-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_weekly_rank_prize.lua

module("logicconfig.config.t_goddess_competition_weekly_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	rankPrizePlanId = 1,
	rankRange = 2
}
local dataList = {
	{
		1,
		{
			1,
			1
		},
		"1名",
		"104:2:1500#4:147:1#8:1:3000000#4:510243:5"
	},
	{
		1,
		{
			2,
			10
		},
		"2~10名",
		"104:2:1000#4:147:1#8:1:2000000#4:510243:4"
	},
	{
		1,
		{
			11,
			100
		},
		"11~100名",
		"104:2:800#4:109:1#8:1:1000000#4:510243:3"
	},
	{
		1,
		{
			101,
			500
		},
		"101~500名",
		"104:2:600#4:108:1#8:1:1000000#4:510243:2"
	},
	{
		1,
		{
			501,
			1000
		},
		"501~1000名",
		"104:2:500#4:108:1#8:1:1000000#4:510243:2"
	}
}
local t_goddess_competition_weekly_rank_prize = {
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
	}
}

t_goddess_competition_weekly_rank_prize.dataList = dataList

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

return t_goddess_competition_weekly_rank_prize
