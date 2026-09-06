-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_red_pack_rank_prize.lua

module("logicconfig.config.t_group_red_pack_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		249001,
		{
			1,
			1
		},
		"第1名",
		"2:86:1#104:2:10000#4:147:1"
	},
	{
		249001,
		{
			2,
			10
		},
		"第2-10名",
		"2:86:1#104:2:8000#4:109:1"
	},
	{
		249001,
		{
			11,
			50
		},
		"第11-50名",
		"2:86:1#104:2:6000#4:108:1"
	},
	{
		249001,
		{
			51,
			100
		},
		"第51-100名",
		"2:86:1#104:2:5000#4:108:1"
	},
	{
		249002,
		{
			1,
			1
		},
		"第1名",
		"2:154:1#104:2:10000#4:147:1"
	},
	{
		249002,
		{
			2,
			10
		},
		"第2-10名",
		"2:154:1#104:2:8000#4:109:1"
	},
	{
		249002,
		{
			11,
			50
		},
		"第11-50名",
		"2:154:1#104:2:6000#4:108:1"
	},
	{
		249002,
		{
			51,
			100
		},
		"第51-100名",
		"2:154:1#104:2:5000#4:108:1"
	}
}
local t_group_red_pack_rank_prize = {
	[249001] = {
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
	[249002] = {
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

t_group_red_pack_rank_prize.dataList = dataList

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

return t_group_red_pack_rank_prize
