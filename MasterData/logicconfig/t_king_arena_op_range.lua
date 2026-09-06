-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_arena_op_range.lua

module("logicconfig.config.t_king_arena_op_range", package.seeall)

local title = {
	opRangeId = 2,
	opRangePlanId = 1,
	rank = 3,
	range = 4
}
local dataList = {
	{
		1,
		1,
		{
			1,
			1
		},
		6
	},
	{
		1,
		2,
		{
			2,
			10
		},
		6
	},
	{
		1,
		3,
		{
			11,
			50
		},
		20
	},
	{
		1,
		4,
		{
			51,
			100
		},
		32
	},
	{
		1,
		5,
		{
			101,
			200
		},
		48
	},
	{
		1,
		6,
		{
			201,
			300
		},
		48
	},
	{
		1,
		7,
		{
			301,
			400
		},
		48
	},
	{
		1,
		8,
		{
			401,
			500
		},
		48
	},
	{
		1,
		9,
		{
			501,
			600
		},
		48
	},
	{
		1,
		10,
		{
			601,
			800
		},
		72
	},
	{
		1,
		11,
		{
			801,
			1000
		},
		72
	},
	{
		1,
		12,
		{
			1001,
			1500
		},
		96
	},
	{
		1,
		13,
		{
			1501,
			2000
		},
		96
	},
	{
		1,
		14,
		{
			2001,
			3000
		},
		96
	},
	{
		1,
		15,
		{
			3001,
			4000
		},
		192
	},
	{
		1,
		16,
		{
			4001,
			5000
		},
		384
	},
	{
		1,
		17,
		{
			5001,
			10000
		},
		800
	},
	{
		1,
		18,
		{
			10001,
			20000
		},
		1000
	},
	{
		1,
		19,
		{
			20001,
			30000
		},
		1500
	},
	{
		1,
		20,
		{
			30001,
			40000
		},
		2000
	},
	{
		1,
		21,
		{
			40001,
			60000
		},
		3000
	},
	{
		1,
		22,
		{
			60001,
			80000
		},
		4000
	}
}
local t_king_arena_op_range = {
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
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	}
}

t_king_arena_op_range.dataList = dataList

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

return t_king_arena_op_range
