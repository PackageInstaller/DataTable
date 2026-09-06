-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_field_score_rank_prize_plan.lua

module("logicconfig.config.t_holy_dragon_field_score_rank_prize_plan", package.seeall)

local title = {
	id = 3,
	rankPlanId = 1,
	prize = 4,
	rankRange = 2
}
local dataList = {
	{
		1,
		{
			1,
			10
		},
		1,
		"2:325:1#104:2:1000#8:1:1000000"
	},
	{
		1,
		{
			11,
			50
		},
		2,
		"2:325:1#104:2:800#8:1:800000"
	},
	{
		1,
		{
			51,
			100
		},
		3,
		"2:325:1#104:2:400#8:1:400000"
	},
	{
		1,
		{
			101,
			1000
		},
		4,
		"2:325:1#104:2:200#8:1:200000"
	},
	{
		1,
		{
			1001,
			2000
		},
		5,
		"2:325:1#104:2:100#8:1:100000"
	},
	{
		1,
		{
			2001,
			3000
		},
		6,
		"2:325:1#104:2:100#8:1:100000"
	},
	{
		2,
		{
			1,
			10
		},
		1,
		"2:324:1#104:2:1000#8:1:1000000"
	},
	{
		2,
		{
			11,
			50
		},
		2,
		"2:324:1#104:2:800#8:1:800000"
	},
	{
		2,
		{
			51,
			100
		},
		3,
		"2:324:1#104:2:400#8:1:400000"
	},
	{
		2,
		{
			101,
			1000
		},
		4,
		"2:324:1#104:2:200#8:1:200000"
	},
	{
		2,
		{
			1001,
			2000
		},
		5,
		"2:324:1#104:2:100#8:1:100000"
	},
	{
		2,
		{
			2001,
			3000
		},
		6,
		"2:324:1#104:2:100#8:1:100000"
	},
	{
		3,
		{
			1,
			10
		},
		1,
		"2:326:1#104:2:1000#8:1:1000000"
	},
	{
		3,
		{
			11,
			50
		},
		2,
		"2:326:1#104:2:800#8:1:800000"
	},
	{
		3,
		{
			51,
			100
		},
		3,
		"2:326:1#104:2:400#8:1:400000"
	},
	{
		3,
		{
			101,
			1000
		},
		4,
		"2:326:1#104:2:200#8:1:200000"
	},
	{
		3,
		{
			1001,
			2000
		},
		5,
		"2:326:1#104:2:100#8:1:100000"
	},
	{
		3,
		{
			2001,
			3000
		},
		6,
		"2:326:1#104:2:100#8:1:100000"
	}
}
local t_holy_dragon_field_score_rank_prize_plan = {
	{
		[{
			1,
			10
		}] = dataList[1],
		[{
			11,
			50
		}] = dataList[2],
		[{
			51,
			100
		}] = dataList[3],
		[{
			101,
			1000
		}] = dataList[4],
		[{
			1001,
			2000
		}] = dataList[5],
		[{
			2001,
			3000
		}] = dataList[6]
	},
	{
		[{
			1,
			10
		}] = dataList[7],
		[{
			11,
			50
		}] = dataList[8],
		[{
			51,
			100
		}] = dataList[9],
		[{
			101,
			1000
		}] = dataList[10],
		[{
			1001,
			2000
		}] = dataList[11],
		[{
			2001,
			3000
		}] = dataList[12]
	},
	{
		[{
			1,
			10
		}] = dataList[13],
		[{
			11,
			50
		}] = dataList[14],
		[{
			51,
			100
		}] = dataList[15],
		[{
			101,
			1000
		}] = dataList[16],
		[{
			1001,
			2000
		}] = dataList[17],
		[{
			2001,
			3000
		}] = dataList[18]
	}
}

t_holy_dragon_field_score_rank_prize_plan.dataList = dataList

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

return t_holy_dragon_field_score_rank_prize_plan
