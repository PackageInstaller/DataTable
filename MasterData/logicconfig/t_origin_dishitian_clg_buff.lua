-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dishitian_clg_buff.lua

module("logicconfig.config.t_origin_dishitian_clg_buff", package.seeall)

local title = {
	pos = 3,
	buffType = 2,
	buffPlanId = 1,
	count = 4
}
local dataList = {
	{
		1,
		1,
		9,
		99
	},
	{
		1,
		2,
		1,
		99
	},
	{
		2,
		1,
		9,
		99
	},
	{
		2,
		2,
		3,
		99
	},
	{
		3,
		1,
		1,
		99
	},
	{
		3,
		2,
		6,
		99
	},
	{
		4,
		1,
		1,
		99
	},
	{
		4,
		2,
		7,
		99
	},
	{
		5,
		1,
		6,
		99
	},
	{
		5,
		2,
		1,
		99
	},
	{
		5,
		2,
		3,
		99
	},
	{
		6,
		1,
		9,
		99
	},
	{
		6,
		2,
		6,
		99
	},
	{
		6,
		2,
		7,
		99
	},
	{
		7,
		1,
		1,
		99
	},
	{
		7,
		2,
		3,
		99
	},
	{
		7,
		2,
		4,
		99
	},
	{
		8,
		1,
		1,
		99
	},
	{
		8,
		2,
		6,
		99
	},
	{
		8,
		2,
		8,
		99
	},
	{
		9,
		1,
		1,
		99
	},
	{
		9,
		2,
		5,
		99
	},
	{
		9,
		1,
		6,
		99
	},
	{
		9,
		2,
		4,
		99
	},
	{
		10,
		1,
		1,
		99
	},
	{
		10,
		2,
		4,
		99
	},
	{
		10,
		1,
		6,
		99
	},
	{
		10,
		2,
		7,
		99
	},
	{
		11,
		1,
		1,
		99
	},
	{
		11,
		2,
		8,
		99
	},
	{
		11,
		1,
		4,
		99
	},
	{
		11,
		2,
		7,
		99
	},
	{
		12,
		1,
		1,
		99
	},
	{
		12,
		2,
		3,
		99
	},
	{
		12,
		1,
		5,
		99
	},
	{
		12,
		2,
		2,
		99
	}
}
local t_origin_dishitian_clg_buff = {
	{
		{
			[9] = dataList[1]
		},
		{
			dataList[2]
		}
	},
	{
		{
			[9] = dataList[3]
		},
		{
			[3] = dataList[4]
		}
	},
	{
		{
			dataList[5]
		},
		{
			[6] = dataList[6]
		}
	},
	{
		{
			dataList[7]
		},
		{
			[7] = dataList[8]
		}
	},
	{
		{
			[6] = dataList[9]
		},
		{
			dataList[10],
			[3] = dataList[11]
		}
	},
	{
		{
			[9] = dataList[12]
		},
		{
			[6] = dataList[13],
			[7] = dataList[14]
		}
	},
	{
		{
			dataList[15]
		},
		{
			[3] = dataList[16],
			[4] = dataList[17]
		}
	},
	{
		{
			dataList[18]
		},
		{
			[6] = dataList[19],
			[8] = dataList[20]
		}
	},
	{
		{
			dataList[21],
			[6] = dataList[23]
		},
		{
			[5] = dataList[22],
			[4] = dataList[24]
		}
	},
	{
		{
			dataList[25],
			[6] = dataList[27]
		},
		{
			[4] = dataList[26],
			[7] = dataList[28]
		}
	},
	{
		{
			dataList[29],
			[4] = dataList[31]
		},
		{
			[8] = dataList[30],
			[7] = dataList[32]
		}
	},
	{
		{
			dataList[33],
			[5] = dataList[35]
		},
		{
			[3] = dataList[34],
			[2] = dataList[36]
		}
	}
}

t_origin_dishitian_clg_buff.dataList = dataList

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

return t_origin_dishitian_clg_buff
