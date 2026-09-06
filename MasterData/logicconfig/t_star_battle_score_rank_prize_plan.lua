-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_score_rank_prize_plan.lua

module("logicconfig.config.t_star_battle_score_rank_prize_plan", package.seeall)

local title = {
	rankPlanId = 1,
	id = 2,
	title = 4,
	prize = 5,
	rankRange = 3
}
local dataList = {
	{
		1,
		1,
		{
			1,
			10
		},
		"第1-10名",
		"1:300079:-1:1#104:2:1000#8:1:1000000"
	},
	{
		1,
		2,
		{
			11,
			20
		},
		"第11-20名",
		"1:300079:-1:1#104:2:800#8:1:800000"
	},
	{
		1,
		3,
		{
			21,
			50
		},
		"第21-50名",
		"1:300079:-1:1#104:2:600#8:1:600000"
	},
	{
		1,
		4,
		{
			51,
			100
		},
		"第51-100名",
		"1:300079:-1:1#104:2:400#8:1:400000"
	},
	{
		1,
		5,
		{
			101,
			300
		},
		"第101-300名",
		"1:300079:-1:1#104:2:200#8:1:200000"
	},
	{
		1,
		6,
		{
			301,
			500
		},
		"第301-500名",
		"1:300079:-1:1#104:2:100#8:1:100000"
	},
	{
		1,
		7,
		{
			501,
			1000
		},
		"第501-1000名",
		"1:300079:-1:1#104:2:50"
	},
	{
		2,
		1,
		{
			1,
			10
		},
		"第1-10名",
		"1:300079:-1:1#104:2:1000#8:1:1000000"
	},
	{
		2,
		2,
		{
			11,
			20
		},
		"第11-20名",
		"1:300079:-1:1#104:2:800#8:1:800000"
	},
	{
		2,
		3,
		{
			21,
			50
		},
		"第21-50名",
		"1:300079:-1:1#104:2:600#8:1:600000"
	},
	{
		2,
		4,
		{
			51,
			100
		},
		"第51-100名",
		"1:300079:-1:1#104:2:400#8:1:400000"
	},
	{
		2,
		5,
		{
			101,
			300
		},
		"第101-300名",
		"1:300079:-1:1#104:2:200#8:1:200000"
	},
	{
		2,
		6,
		{
			301,
			500
		},
		"第301-500名",
		"1:300079:-1:1#104:2:100#8:1:100000"
	},
	{
		2,
		7,
		{
			501,
			1000
		},
		"第501-1000名",
		"1:300079:-1:1#104:2:50"
	}
}
local t_star_battle_score_rank_prize_plan = {
	{
		{
			[{
				1,
				10
			}] = dataList[1]
		},
		{
			[{
				11,
				20
			}] = dataList[2]
		},
		{
			[{
				21,
				50
			}] = dataList[3]
		},
		{
			[{
				51,
				100
			}] = dataList[4]
		},
		{
			[{
				101,
				300
			}] = dataList[5]
		},
		{
			[{
				301,
				500
			}] = dataList[6]
		},
		{
			[{
				501,
				1000
			}] = dataList[7]
		}
	},
	{
		{
			[{
				1,
				10
			}] = dataList[8]
		},
		{
			[{
				11,
				20
			}] = dataList[9]
		},
		{
			[{
				21,
				50
			}] = dataList[10]
		},
		{
			[{
				51,
				100
			}] = dataList[11]
		},
		{
			[{
				101,
				300
			}] = dataList[12]
		},
		{
			[{
				301,
				500
			}] = dataList[13]
		},
		{
			[{
				501,
				1000
			}] = dataList[14]
		}
	}
}

t_star_battle_score_rank_prize_plan.dataList = dataList

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

return t_star_battle_score_rank_prize_plan
