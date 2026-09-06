-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_rank_prize.lua

module("logicconfig.config.t_goddess_contest_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	actId = 1,
	rankRange = 2
}
local dataList = {
	{
		251001,
		{
			1,
			1
		},
		"第1名",
		"2:87:1#104:2:1000#8:1:1000000"
	},
	{
		251001,
		{
			2,
			10
		},
		"第2-10名",
		"2:87:1#104:2:800#8:1:1000000"
	},
	{
		251001,
		{
			11,
			50
		},
		"第11-50名",
		"2:87:1#104:2:600#8:1:1000000"
	},
	{
		251001,
		{
			51,
			100
		},
		"第51-100名",
		"2:87:1#104:2:500#8:1:1000000"
	},
	{
		251002,
		{
			1,
			1
		},
		"第1名",
		"2:155:1#104:2:1000#8:1:10000000"
	},
	{
		251002,
		{
			2,
			10
		},
		"第2-10名",
		"2:155:1#104:2:800#8:1:8000000"
	},
	{
		251002,
		{
			11,
			50
		},
		"第11-50名",
		"2:155:1#104:2:600#8:1:5000000"
	},
	{
		251002,
		{
			51,
			100
		},
		"第51-100名",
		"2:155:1#104:2:500#8:1:3000000"
	}
}
local t_goddess_contest_rank_prize = {
	[251001] = {
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
	[251002] = {
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

t_goddess_contest_rank_prize.dataList = dataList

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

return t_goddess_contest_rank_prize
