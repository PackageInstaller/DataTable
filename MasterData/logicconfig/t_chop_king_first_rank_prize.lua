-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_first_rank_prize.lua

module("logicconfig.config.t_chop_king_first_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		470001,
		{
			1,
			1
		},
		"1名",
		"104:2:1000#8:1:1000000"
	},
	{
		470001,
		{
			2,
			10
		},
		"2~10名",
		"104:2:800#8:1:800000"
	},
	{
		470001,
		{
			11,
			100
		},
		"11~100名",
		"104:2:600#8:1:600000"
	},
	{
		470001,
		{
			101,
			500
		},
		"101~500名",
		"104:2:400#8:1:400000"
	},
	{
		470001,
		{
			501,
			1000
		},
		"501~1000名",
		"104:2:200#8:1:200000"
	}
}
local t_chop_king_first_rank_prize = {
	[470001] = {
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

t_chop_king_first_rank_prize.dataList = dataList

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

return t_chop_king_first_rank_prize
