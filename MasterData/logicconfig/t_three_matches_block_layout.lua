-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_block_layout.lua

module("logicconfig.config.t_three_matches_block_layout", package.seeall)

local title = {
	rowId = 2,
	layoutId = 1,
	blocksRow = 3
}
local dataList = {
	{
		1,
		8,
		{
			11,
			9,
			8,
			8,
			9,
			8,
			9,
			10
		}
	},
	{
		1,
		7,
		{
			11,
			8,
			8,
			9,
			9,
			10,
			10,
			11
		}
	},
	{
		1,
		6,
		{
			9,
			10,
			10,
			8,
			11,
			11,
			8,
			9
		}
	},
	{
		1,
		5,
		{
			11,
			10,
			11,
			11,
			10,
			8,
			10,
			10
		}
	},
	{
		1,
		4,
		{
			8,
			8,
			9,
			10,
			11,
			11,
			9,
			9
		}
	},
	{
		1,
		3,
		{
			8,
			11,
			11,
			9,
			10,
			8,
			9,
			10
		}
	},
	{
		1,
		2,
		{
			10,
			11,
			8,
			8,
			9,
			9,
			8,
			8
		}
	},
	{
		1,
		1,
		{
			9,
			9,
			11,
			11,
			8,
			11,
			10,
			10
		}
	},
	{
		2,
		8,
		{
			11,
			9,
			8,
			8,
			9,
			10,
			8,
			11
		}
	},
	{
		2,
		7,
		{
			11,
			10,
			9,
			11,
			9,
			11,
			10,
			9
		}
	},
	{
		2,
		6,
		{
			10,
			9,
			11,
			8,
			8,
			11,
			9,
			9
		}
	},
	{
		2,
		5,
		{
			9,
			8,
			9,
			11,
			11,
			8,
			11,
			11
		}
	},
	{
		2,
		4,
		{
			11,
			9,
			8,
			8,
			9,
			10,
			8,
			11
		}
	},
	{
		2,
		3,
		{
			11,
			10,
			9,
			11,
			9,
			11,
			10,
			9
		}
	},
	{
		2,
		2,
		{
			10,
			9,
			11,
			8,
			8,
			11,
			9,
			11
		}
	},
	{
		2,
		1,
		{
			9,
			8,
			9,
			11,
			11,
			8,
			11,
			11
		}
	},
	{
		3,
		8,
		{
			11,
			11,
			8,
			11,
			8,
			8,
			9,
			10
		}
	},
	{
		3,
		7,
		{
			8,
			11,
			11,
			9,
			11,
			10,
			10,
			9
		}
	},
	{
		3,
		6,
		{
			8,
			10,
			10,
			11,
			11,
			8,
			11,
			9
		}
	},
	{
		3,
		5,
		{
			10,
			10,
			12,
			12,
			10,
			12,
			10,
			10
		}
	},
	{
		3,
		4,
		{
			8,
			8,
			9,
			10,
			11,
			12,
			9,
			9
		}
	},
	{
		3,
		3,
		{
			9,
			10,
			8,
			9,
			12,
			8,
			9,
			12
		}
	},
	{
		3,
		2,
		{
			10,
			9,
			9,
			8,
			9,
			9,
			8,
			8
		}
	},
	{
		3,
		1,
		{
			9,
			9,
			12,
			8,
			12,
			8,
			12,
			12
		}
	}
}
local t_three_matches_block_layout = {
	{
		[8] = dataList[1],
		[7] = dataList[2],
		[6] = dataList[3],
		[5] = dataList[4],
		[4] = dataList[5],
		[3] = dataList[6],
		[2] = dataList[7],
		dataList[8]
	},
	{
		[8] = dataList[9],
		[7] = dataList[10],
		[6] = dataList[11],
		[5] = dataList[12],
		[4] = dataList[13],
		[3] = dataList[14],
		[2] = dataList[15],
		dataList[16]
	},
	{
		[8] = dataList[17],
		[7] = dataList[18],
		[6] = dataList[19],
		[5] = dataList[20],
		[4] = dataList[21],
		[3] = dataList[22],
		[2] = dataList[23],
		dataList[24]
	}
}

t_three_matches_block_layout.dataList = dataList

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

return t_three_matches_block_layout
