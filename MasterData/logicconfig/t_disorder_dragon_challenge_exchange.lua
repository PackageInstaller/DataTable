-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_dragon_challenge_exchange.lua

module("logicconfig.config.t_disorder_dragon_challenge_exchange", package.seeall)

local title = {
	condition = 4,
	skinId = 5,
	buffId = 3,
	exchangeId = 2,
	pos = 6,
	extremeChangePlan = 1
}
local dataList = {
	{
		1,
		1,
		1,
		{
			1,
			1000000
		},
		16011,
		{
			-238.38,
			-644.58,
			1
		}
	},
	{
		1,
		2,
		2,
		{
			1000001,
			10000000
		},
		17003,
		{
			-59.3,
			-505.5,
			1
		}
	},
	{
		1,
		3,
		3,
		{
			10000001,
			20000000
		},
		16010,
		{
			12,
			-579,
			1
		}
	},
	{
		1,
		4,
		4,
		{
			20000001,
			30000000
		},
		16004,
		{
			-148.6,
			-510.1,
			1
		}
	},
	{
		1,
		5,
		5,
		{
			30000001,
			40000000
		},
		16001,
		{
			-60.7,
			-653.5,
			1
		}
	},
	{
		1,
		6,
		6,
		{
			40000001,
			50000000
		},
		1600101,
		{
			-60.7,
			-653.5,
			1
		}
	},
	{
		1,
		7,
		7,
		{
			50000001,
			60000000
		},
		11002,
		{
			-16,
			-628,
			0.2
		}
	},
	{
		1,
		8,
		8,
		{
			60000001,
			70000000
		},
		10324,
		{
			-52,
			-522,
			1
		}
	},
	{
		1,
		9,
		9,
		{
			70000001,
			80000000
		},
		10314,
		{
			-124.2,
			-543,
			1
		}
	},
	{
		1,
		10,
		10,
		{
			80000001,
			90000000
		},
		10313,
		{
			-103.3,
			-586,
			1
		}
	},
	{
		1,
		11,
		11,
		{
			90000001,
			100000000
		},
		17002,
		{
			35.7,
			-727.5,
			1
		}
	}
}
local t_disorder_dragon_challenge_exchange = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_disorder_dragon_challenge_exchange.dataList = dataList

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

return t_disorder_dragon_challenge_exchange
