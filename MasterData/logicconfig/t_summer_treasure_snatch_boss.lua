-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_boss.lua

module("logicconfig.config.t_summer_treasure_snatch_boss", package.seeall)

local title = {
	bossId = 3,
	week = 2,
	posNScale = 6,
	skinId = 5,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		623001,
		1,
		1,
		1015,
		16046,
		{
			40,
			-642,
			1
		}
	},
	{
		623001,
		1,
		2,
		1014,
		15051,
		{
			80,
			-642,
			1
		}
	},
	{
		623001,
		1,
		3,
		1013,
		14048,
		{
			-75,
			-600,
			1
		}
	},
	{
		623001,
		1,
		4,
		1018,
		1404503,
		{
			0,
			-460,
			0.7
		}
	},
	{
		623001,
		2,
		1,
		1015,
		16046,
		{
			80,
			-642,
			1
		}
	},
	{
		623001,
		2,
		2,
		1012,
		12047,
		{
			0,
			-542,
			1
		}
	},
	{
		623001,
		2,
		3,
		1014,
		15051,
		{
			80,
			-642,
			1
		}
	},
	{
		623001,
		2,
		4,
		1016,
		16047,
		{
			-15,
			-639,
			1
		}
	},
	{
		623001,
		3,
		1,
		1017,
		16048,
		{
			0,
			-650,
			1
		}
	},
	{
		623001,
		3,
		2,
		1015,
		16046,
		{
			40,
			-642,
			1
		}
	},
	{
		623001,
		3,
		3,
		1012,
		12047,
		{
			0,
			-542,
			1
		}
	},
	{
		623001,
		3,
		4,
		1014,
		15051,
		{
			80,
			-642,
			1
		}
	},
	{
		623001,
		4,
		1,
		1017,
		16048,
		{
			0,
			-650,
			1
		}
	},
	{
		623001,
		4,
		2,
		1015,
		16046,
		{
			40,
			-642,
			1
		}
	},
	{
		623001,
		4,
		3,
		1014,
		15051,
		{
			80,
			-642,
			1
		}
	},
	{
		623001,
		4,
		4,
		1016,
		16047,
		{
			-15,
			-639,
			1
		}
	}
}
local t_summer_treasure_snatch_boss = {
	[623001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		}
	}
}

t_summer_treasure_snatch_boss.dataList = dataList

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

return t_summer_treasure_snatch_boss
