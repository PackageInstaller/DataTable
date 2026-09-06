-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_never_land_rank_prize.lua

module("logicconfig.config.t_never_land_rank_prize", package.seeall)

local title = {
	prize = 5,
	mode = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		294001,
		"attack",
		{
			1,
			1
		},
		"第1名",
		"2:104:1#104:2:1000#8:1:1000000"
	},
	{
		294001,
		"attack",
		{
			2,
			10
		},
		"第2-10名",
		"2:104:1#104:2:800#8:1:1000000"
	},
	{
		294001,
		"attack",
		{
			11,
			100
		},
		"第11-100名",
		"2:104:1#104:2:600#8:1:1000000"
	},
	{
		294001,
		"attack",
		{
			101,
			500
		},
		"第101-500名",
		"2:104:1#104:2:500#8:1:1000000"
	},
	{
		294001,
		"defense",
		{
			1,
			1
		},
		"第1名",
		"2:103:1#104:2:1000#8:1:1000000"
	},
	{
		294001,
		"defense",
		{
			2,
			10
		},
		"第2-10名",
		"2:103:1#104:2:800#8:1:1000000"
	},
	{
		294001,
		"defense",
		{
			11,
			100
		},
		"第11-100名",
		"2:103:1#104:2:600#8:1:1000000"
	},
	{
		294001,
		"defense",
		{
			101,
			500
		},
		"第101-500名",
		"2:103:1#104:2:500#8:1:1000000"
	}
}
local t_never_land_rank_prize = {
	[294001] = {
		attack = {
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
			}] = dataList[4]
		},
		defense = {
			[{
				1,
				1
			}] = dataList[5],
			[{
				2,
				10
			}] = dataList[6],
			[{
				11,
				100
			}] = dataList[7],
			[{
				101,
				500
			}] = dataList[8]
		}
	}
}

t_never_land_rank_prize.dataList = dataList

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

return t_never_land_rank_prize
