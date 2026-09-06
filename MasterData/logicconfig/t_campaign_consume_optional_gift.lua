-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_campaign_consume_optional_gift.lua

module("logicconfig.config.t_campaign_consume_optional_gift", package.seeall)

local title = {
	scale = 5,
	seq = 2,
	optionalGift = 3,
	pos = 4,
	optionalId = 1
}
local dataList = {
	{
		1,
		1,
		"17:1013001:-1:1",
		{
			-199,
			-534
		},
		{
			1.5,
			1.5
		}
	},
	{
		1,
		2,
		"17:1016701:-1:1",
		{
			-128,
			-534
		},
		{
			1.5,
			1.5
		}
	},
	{
		1,
		3,
		"17:1020301:-1:1",
		{
			-128,
			-534
		},
		{
			1.5,
			1.5
		}
	},
	{
		1,
		4,
		"17:1030901:-1:1",
		{
			-199,
			-534
		},
		{
			1.5,
			1.5
		}
	},
	{
		2,
		1,
		"17:1014301:-1:1",
		{
			-199,
			-534
		},
		{
			1.5,
			1.5
		}
	},
	{
		2,
		2,
		"17:1032301:-1:1",
		{
			-128,
			-534
		},
		{
			1.5,
			1.5
		}
	},
	{
		2,
		3,
		"17:1014701:-1:1",
		{
			-128,
			-534
		},
		{
			1.5,
			1.5
		}
	}
}
local t_campaign_consume_optional_gift = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_campaign_consume_optional_gift.dataList = dataList

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

return t_campaign_consume_optional_gift
