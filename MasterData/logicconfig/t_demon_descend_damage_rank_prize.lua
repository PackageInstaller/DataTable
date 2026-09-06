-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_demon_descend_damage_rank_prize.lua

module("logicconfig.config.t_demon_descend_damage_rank_prize", package.seeall)

local title = {
	prize = 5,
	id = 3,
	title = 4,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		497001,
		{
			1,
			10
		},
		1,
		"第1-10名",
		"104:2:1000#8:1:10000000"
	},
	{
		497001,
		{
			11,
			20
		},
		2,
		"第11-20名",
		"104:2:800#8:1:8000000"
	},
	{
		497001,
		{
			21,
			50
		},
		3,
		"第21-50名",
		"104:2:700#8:1:7000000"
	},
	{
		497001,
		{
			51,
			100
		},
		4,
		"第51-100名",
		"104:2:600#8:1:6000000"
	},
	{
		497001,
		{
			101,
			300
		},
		5,
		"第101-300名",
		"104:2:500#8:1:5000000"
	},
	{
		497001,
		{
			301,
			500
		},
		6,
		"第301-500名",
		"104:2:400#8:1:4000000"
	},
	{
		497001,
		{
			501,
			700
		},
		7,
		"第501-700名",
		"104:2:300#8:1:3000000"
	},
	{
		497001,
		{
			701,
			1000
		},
		8,
		"第701-1000名",
		"104:2:200#8:1:2000000"
	}
}
local t_demon_descend_damage_rank_prize = {
	[497001] = {
		[{
			1,
			10
		}] = dataList[1],
		[{
			11,
			20
		}] = dataList[2],
		[{
			21,
			50
		}] = dataList[3],
		[{
			51,
			100
		}] = dataList[4],
		[{
			101,
			300
		}] = dataList[5],
		[{
			301,
			500
		}] = dataList[6],
		[{
			501,
			700
		}] = dataList[7],
		[{
			701,
			1000
		}] = dataList[8]
	}
}

t_demon_descend_damage_rank_prize.dataList = dataList

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

return t_demon_descend_damage_rank_prize
