-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_score_match_rank_prize.lua

module("logicconfig.config.t_young_arena_king_s3_score_match_rank_prize", package.seeall)

local title = {
	prize = 4,
	mailTemplateId = 5,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		624001,
		{
			1,
			1
		},
		"第1名",
		"2:335:1#104:2:1000#8:1:10000000",
		263
	},
	{
		624001,
		{
			2,
			2
		},
		"第2名",
		"2:336:1#104:2:800#8:1:8000000",
		263
	},
	{
		624001,
		{
			3,
			3
		},
		"第3名",
		"2:337:1#104:2:700#8:1:7000000",
		263
	},
	{
		624001,
		{
			4,
			20
		},
		"4-20名",
		"104:2:600#8:1:6000000",
		263
	},
	{
		624001,
		{
			21,
			40
		},
		"21-40名",
		"104:2:500#8:1:5000000",
		263
	},
	{
		624001,
		{
			41,
			80
		},
		"41-80名",
		"104:2:400#8:1:4000000",
		263
	},
	{
		624001,
		{
			81,
			160
		},
		"81-160名",
		"104:2:300#8:1:3000000",
		263
	},
	{
		624001,
		{
			161,
			320
		},
		"161-320名",
		"104:2:200#8:1:2000000",
		263
	}
}
local t_young_arena_king_s3_score_match_rank_prize = {
	[624001] = {
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
			40
		}] = dataList[5],
		[{
			41,
			80
		}] = dataList[6],
		[{
			81,
			160
		}] = dataList[7],
		[{
			161,
			320
		}] = dataList[8]
	}
}

t_young_arena_king_s3_score_match_rank_prize.dataList = dataList

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

return t_young_arena_king_s3_score_match_rank_prize
