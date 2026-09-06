-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_market_price_plan.lua

module("logicconfig.config.t_anniversary_market_price_plan", package.seeall)

local title = {
	pricePlanId = 1,
	priceRange = 2
}
local dataList = {
	{
		1,
		{
			101,
			200
		}
	},
	{
		1,
		{
			201,
			300
		}
	},
	{
		1,
		{
			301,
			400
		}
	},
	{
		1,
		{
			401,
			500
		}
	},
	{
		1,
		{
			501,
			600
		}
	},
	{
		1,
		{
			601,
			700
		}
	},
	{
		1,
		{
			701,
			800
		}
	},
	{
		2,
		{
			101,
			200
		}
	},
	{
		2,
		{
			201,
			300
		}
	},
	{
		2,
		{
			301,
			400
		}
	},
	{
		2,
		{
			401,
			500
		}
	},
	{
		2,
		{
			501,
			600
		}
	},
	{
		2,
		{
			601,
			700
		}
	},
	{
		2,
		{
			701,
			800
		}
	}
}
local t_anniversary_market_price_plan = {
	{
		[{
			101,
			200
		}] = dataList[1],
		[{
			201,
			300
		}] = dataList[2],
		[{
			301,
			400
		}] = dataList[3],
		[{
			401,
			500
		}] = dataList[4],
		[{
			501,
			600
		}] = dataList[5],
		[{
			601,
			700
		}] = dataList[6],
		[{
			701,
			800
		}] = dataList[7]
	},
	{
		[{
			101,
			200
		}] = dataList[8],
		[{
			201,
			300
		}] = dataList[9],
		[{
			301,
			400
		}] = dataList[10],
		[{
			401,
			500
		}] = dataList[11],
		[{
			501,
			600
		}] = dataList[12],
		[{
			601,
			700
		}] = dataList[13],
		[{
			701,
			800
		}] = dataList[14]
	}
}

t_anniversary_market_price_plan.dataList = dataList

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

return t_anniversary_market_price_plan
