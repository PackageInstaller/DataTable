-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_manufacture.lua

module("logic.config.t_house_manufacture", package.seeall)

local title = {
	jobCount = 8,
	name = 5,
	cost = 2,
	store = 9,
	upgradeDesc = 10,
	desc = 6,
	plant = 7,
	productivity = 3,
	icon = 4,
	level = 1
}
local dataList = {
	{
		1,
		{
			{
				id = 1702001,
				num = 3
			},
			{
				id = 1100003,
				num = 200
			}
		},
		100,
		"10005",
		"制造厂.Lv1",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		1,
		1,
		90,
		"库存容量+10\r\n解锁更多材料方案"
	},
	{
		2,
		{
			{
				id = 1702001,
				num = 15
			},
			{
				id = 1100003,
				num = 500
			}
		},
		100,
		"10005",
		"制造厂.Lv2",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		1,
		1,
		100,
		"编制职位+1\r\n库存容量+10"
	},
	{
		3,
		{
			{
				id = 1702001,
				num = 35
			},
			{
				id = 1100003,
				num = 1000
			}
		},
		100,
		"10005",
		"制造厂.Lv3",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		1,
		2,
		110,
		"制造车间+1\r\n库存容量+10"
	},
	{
		4,
		{
			{
				id = 1702002,
				num = 10
			},
			{
				id = 1702001,
				num = 16
			},
			{
				id = 1100003,
				num = 2000
			}
		},
		100,
		"10005",
		"制造厂.Lv4",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		2,
		2,
		120,
		"库存容量+10\r\n解锁更多材料方案"
	},
	{
		5,
		{
			{
				id = 1702002,
				num = 20
			},
			{
				id = 1702001,
				num = 30
			},
			{
				id = 1100003,
				num = 5000
			}
		},
		100,
		"10005",
		"制造厂.Lv5",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		2,
		2,
		130,
		"库存容量+10"
	},
	{
		6,
		{
			{
				id = 1702002,
				num = 25
			},
			{
				id = 1702001,
				num = 40
			},
			{
				id = 1100003,
				num = 10000
			}
		},
		100,
		"10005",
		"制造厂.Lv6",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		2,
		2,
		140,
		"编制职位+1\r\n库存容量+10"
	},
	{
		7,
		{
			{
				id = 1702003,
				num = 10
			},
			{
				id = 1702002,
				num = 25
			},
			{
				id = 1100003,
				num = 20000
			}
		},
		100,
		"10005",
		"制造厂.Lv7",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		2,
		3,
		150,
		"制造车间+1\r\n库存容量+10"
	},
	{
		8,
		{
			{
				id = 1702003,
				num = 15
			},
			{
				id = 1702002,
				num = 30
			},
			{
				id = 1100003,
				num = 30000
			}
		},
		100,
		"10005",
		"制造厂.Lv8",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		3,
		3,
		160,
		"库存容量+20\r\n解锁更多材料方案"
	},
	{
		9,
		{
			{
				id = 1702003,
				num = 20
			},
			{
				id = 1702002,
				num = 40
			},
			{
				id = 1100003,
				num = 50000
			}
		},
		100,
		"10005",
		"制造厂.Lv9",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		3,
		3,
		180,
		"库存容量+20\r\n解锁更多材料方案"
	},
	{
		10,
		nil,
		100,
		"10005",
		"制造厂.Lv10",
		"以太的能量驱动着机械的运作，辅以精巧的设计，将创造出更多可能。",
		3,
		3,
		200,
		""
	}
}
local t_house_manufacture = {}

t_house_manufacture.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_house_manufacture[v[1]] = v

	setmetatable(v, mt)
end

return t_house_manufacture
