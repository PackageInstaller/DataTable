-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_unit.lua

module("logicconfig.config.t_king_dragon_unit", package.seeall)

local title = {
	partName = 7,
	prize = 4,
	buffId = 5,
	unitId = 2,
	creepsMasterId = 3,
	partPos = 8,
	planId = 1,
	deBuffId = 6
}
local dataList = {
	{
		1,
		1,
		3101,
		"4:151:1",
		1,
		6,
		"龙角",
		{
			123,
			210
		}
	},
	{
		1,
		2,
		3102,
		"4:151:1",
		2,
		7,
		"龙翼",
		{
			-400,
			120
		}
	},
	{
		1,
		3,
		3103,
		"4:151:1",
		3,
		8,
		"龙鳞",
		{
			-66,
			30
		}
	},
	{
		1,
		4,
		3104,
		"4:151:1",
		4,
		9,
		"龙胆",
		{
			205,
			-40
		}
	},
	{
		1,
		5,
		3105,
		"4:151:1",
		5,
		10,
		"龙爪",
		{
			-70,
			-210
		}
	},
	{
		2,
		1,
		5101,
		"4:157:1",
		11,
		16,
		"回忆",
		{
			-549,
			170
		}
	},
	{
		2,
		2,
		5102,
		"4:157:1",
		12,
		17,
		"亲情",
		{
			-477,
			-4
		}
	},
	{
		2,
		3,
		5103,
		"4:157:1",
		13,
		18,
		"寄念",
		{
			-338,
			-154
		}
	},
	{
		2,
		4,
		5104,
		"4:157:1",
		14,
		19,
		"寻忆",
		{
			-129,
			-256
		}
	},
	{
		2,
		5,
		5105,
		"4:157:1",
		15,
		20,
		"时忆",
		{
			114,
			-280
		}
	}
}
local t_king_dragon_unit = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_king_dragon_unit.dataList = dataList

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

return t_king_dragon_unit
