-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_six_art_daoguan_rank_prize.lua

module("logicconfig.config.t_six_art_daoguan_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		447001,
		{
			1,
			1
		},
		"1名",
		"2:210:1#104:2:2000"
	},
	{
		447001,
		{
			2,
			5
		},
		"2~5名",
		"2:210:1#104:2:1500"
	},
	{
		447001,
		{
			6,
			20
		},
		"6~20名",
		"2:210:1#104:2:1200"
	},
	{
		447001,
		{
			21,
			50
		},
		"21~50名",
		"2:210:1#104:2:1000"
	},
	{
		447001,
		{
			51,
			100
		},
		"51~100名",
		"2:210:1#104:2:800"
	},
	{
		447001,
		{
			101,
			1000
		},
		"101~1000名",
		"2:210:1#104:2:600"
	},
	{
		447001,
		{
			1001,
			5000
		},
		"1001~5000名",
		"2:210:1#104:2:400"
	},
	{
		447001,
		{
			5001,
			10000
		},
		"5001~1000名",
		"104:2:200"
	}
}
local t_six_art_daoguan_rank_prize = {
	[447001] = {
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
			1000
		}] = dataList[6],
		[{
			1001,
			5000
		}] = dataList[7],
		[{
			5001,
			10000
		}] = dataList[8]
	}
}

t_six_art_daoguan_rank_prize.dataList = dataList

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

return t_six_art_daoguan_rank_prize
