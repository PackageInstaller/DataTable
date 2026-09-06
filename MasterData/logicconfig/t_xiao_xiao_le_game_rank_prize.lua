-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_xiao_le_game_rank_prize.lua

module("logicconfig.config.t_xiao_xiao_le_game_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		454001,
		{
			1,
			1
		},
		"1名",
		"104:2:1000#8:1:1000000"
	},
	{
		454001,
		{
			2,
			5
		},
		"2~5名",
		"104:2:800#8:1:800000"
	},
	{
		454001,
		{
			6,
			20
		},
		"6~20名",
		"104:2:600#8:1:600000"
	},
	{
		454001,
		{
			21,
			50
		},
		"21~50名",
		"104:2:400#8:1:500000"
	},
	{
		454001,
		{
			51,
			100
		},
		"51~100名",
		"104:2:300#8:1:400000"
	},
	{
		454001,
		{
			101,
			1000
		},
		"101~1000名",
		"104:2:200#8:1:300000"
	}
}
local t_xiao_xiao_le_game_rank_prize = {
	[454001] = {
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
		}] = dataList[6]
	}
}

t_xiao_xiao_le_game_rank_prize.dataList = dataList

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

return t_xiao_xiao_le_game_rank_prize
