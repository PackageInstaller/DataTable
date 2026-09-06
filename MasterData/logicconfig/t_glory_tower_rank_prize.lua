-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_tower_rank_prize.lua

module("logicconfig.config.t_glory_tower_rank_prize", package.seeall)

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
		"第1名",
		"2:89:1#104:2:1000#4:109:1"
	},
	{
		1,
		{
			2,
			10
		},
		"第2-10名",
		"2:89:1#104:2:800#4:108:1"
	},
	{
		1,
		{
			11,
			50
		},
		"第11-50名",
		"2:89:1#104:2:600#4:108:1"
	},
	{
		1,
		{
			51,
			100
		},
		"第51-100名",
		"2:89:1#104:2:500#4:107:1"
	},
	{
		2,
		{
			1,
			1
		},
		"第1名",
		"2:88:1#104:2:1000#4:109:1"
	},
	{
		2,
		{
			2,
			10
		},
		"第2-10名",
		"2:88:1#104:2:800#4:108:1"
	},
	{
		2,
		{
			11,
			50
		},
		"第11-50名",
		"2:88:1#104:2:600#4:108:1"
	},
	{
		2,
		{
			51,
			100
		},
		"第51-100名",
		"2:88:1#104:2:500#4:107:1"
	}
}
local t_glory_tower_rank_prize = {
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
			50
		}] = dataList[3],
		[{
			51,
			100
		}] = dataList[4]
	},
	{
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
			50
		}] = dataList[7],
		[{
			51,
			100
		}] = dataList[8]
	}
}

t_glory_tower_rank_prize.dataList = dataList

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

return t_glory_tower_rank_prize
