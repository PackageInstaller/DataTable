-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_pvp_rank_prize.lua

module("logicconfig.config.t_magic_school_pvp_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 3,
	title = 4,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		514001,
		{
			1,
			1
		},
		1,
		"1名",
		"2:253:1#104:2:1500"
	},
	{
		514001,
		{
			2,
			5
		},
		2,
		"2~5名",
		"2:253:1#104:2:1200"
	},
	{
		514001,
		{
			6,
			20
		},
		3,
		"6~20名",
		"2:253:1#104:2:1000"
	},
	{
		514001,
		{
			21,
			50
		},
		4,
		"21~50名",
		"2:253:1#104:2:800"
	},
	{
		514001,
		{
			51,
			100
		},
		5,
		"51~100名",
		"2:253:1#104:2:500"
	},
	{
		514001,
		{
			101,
			500
		},
		6,
		"101~500名",
		"2:253:1#104:2:300"
	},
	{
		514001,
		{
			501,
			1000
		},
		7,
		"501~1000名",
		"2:253:1#104:2:100"
	}
}
local t_magic_school_pvp_rank_prize = {
	[514001] = {
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

t_magic_school_pvp_rank_prize.dataList = dataList

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

return t_magic_school_pvp_rank_prize
