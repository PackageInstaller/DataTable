-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_rungroup_moster_cut.lua

module("logic.config.t_rungroup_moster_cut", package.seeall)

local title = {
	posSizeInfo = 2,
	name = 1,
	posSizeInfo2 = 3,
	posSizeInfo1 = 4
}
local dataList = {
	{
		"1001",
		{
			-10,
			10,
			1.2,
			1.2
		},
		{
			-10,
			-120,
			2.3,
			0.7
		},
		{
			46,
			-12,
			1,
			1
		}
	},
	{
		"1002",
		{
			-52,
			30,
			1.2,
			1.2
		},
		{
			0,
			-120,
			2,
			0.5
		},
		{
			0,
			-36,
			0.85,
			0.85
		}
	},
	{
		"1003",
		{
			4,
			-46,
			0.8,
			0.8
		},
		{
			-10,
			-110,
			2.3,
			0.6
		},
		{
			60,
			-10,
			0.7,
			0.7
		}
	},
	{
		"10001",
		{
			-10,
			30,
			1.1,
			1.1
		},
		{
			-10,
			-120,
			2.3,
			0.7
		},
		{
			20,
			-26,
			0.7,
			0.7
		}
	},
	{
		"10201",
		{
			-30,
			46,
			1.3,
			1.3
		},
		{
			-10,
			-126,
			1,
			0.3
		},
		{
			10,
			-100,
			1.2,
			1.2
		}
	},
	{
		"20001",
		{
			-17,
			-10,
			1.2,
			1.2
		},
		{
			-17,
			-118,
			2.1,
			0.6
		},
		{
			0,
			10,
			0.7,
			0.7
		}
	},
	{
		"100003",
		{
			-10,
			0,
			1.5,
			1.5
		},
		{
			-22,
			-124,
			2.3,
			0.7
		},
		{
			20,
			-16,
			0.9,
			0.9
		}
	}
}
local t_rungroup_moster_cut = {}

t_rungroup_moster_cut.dataList = dataList

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
	t_rungroup_moster_cut[v[1]] = v

	setmetatable(v, mt)
end

return t_rungroup_moster_cut
