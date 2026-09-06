-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter3_explore_rank_prize.lua

module("logicconfig.config.t_luyngarde_chapter3_explore_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		466001,
		{
			1,
			1
		},
		"1名",
		"1:300067:-1:1#104:2:2000"
	},
	{
		466001,
		{
			2,
			5
		},
		"2~5名",
		"1:300067:-1:1#104:2:1500"
	},
	{
		466001,
		{
			6,
			20
		},
		"6~20名",
		"1:300067:-1:1#104:2:1200"
	},
	{
		466001,
		{
			21,
			50
		},
		"21~50名",
		"1:300067:-1:1#104:2:1000"
	},
	{
		466001,
		{
			51,
			100
		},
		"51~100名",
		"1:300067:-1:1#104:2:800"
	},
	{
		466001,
		{
			101,
			500
		},
		"101~500名",
		"1:300067:-1:1#104:2:500"
	},
	{
		466001,
		{
			501,
			1000
		},
		"501~1000名",
		"1:300067:-1:1#104:2:300"
	}
}
local t_luyngarde_chapter3_explore_rank_prize = {
	[466001] = {
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
	}
}

t_luyngarde_chapter3_explore_rank_prize.dataList = dataList

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

return t_luyngarde_chapter3_explore_rank_prize
