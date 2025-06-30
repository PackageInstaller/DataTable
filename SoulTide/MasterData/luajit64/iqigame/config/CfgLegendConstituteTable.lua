-- chunkname: @IQIGame\\Config\\CfgLegendConstituteTable.lua

local CfgLegendConstituteTable = {
	{
		Id = 1,
		RuneConstitute = {
			3,
			5
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000101
		},
		SoulTeamFightBuff = {
			301921
		}
	},
	{
		Id = 2,
		RuneConstitute = {
			4,
			21
		},
		ConstituteNum = {
			4,
			6
		},
		Buff = {
			100000102
		},
		SoulTeamFightBuff = {
			301931
		}
	},
	{
		Id = 3,
		RuneConstitute = {
			8,
			7
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000103
		},
		AllSoulFightBuff = {
			301941
		}
	},
	{
		Id = 4,
		RuneConstitute = {
			9,
			1
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000104
		},
		SoulTeamFightBuff = {
			301951
		}
	},
	{
		Id = 5,
		RuneConstitute = {
			10,
			2
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000105
		},
		AllSoulFightBuff = {
			301961
		}
	},
	{
		Id = 6,
		RuneConstitute = {
			16,
			11
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000106
		},
		SoulTeamFightBuff = {
			301971
		}
	},
	{
		Id = 7,
		RuneConstitute = {
			17,
			12
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000107
		},
		SoulTeamFightBuff = {
			301981
		}
	},
	{
		Id = 8,
		RuneConstitute = {
			18,
			13
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000108
		},
		SoulTeamFightBuff = {
			301991
		}
	},
	{
		Id = 9,
		RuneConstitute = {
			19,
			14
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000109
		},
		AllSoulFightBuff = {
			302001
		}
	},
	{
		Id = 10,
		RuneConstitute = {
			20,
			15
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000110
		},
		AllSoulFightBuff = {
			302011
		}
	},
	{
		Id = 11,
		RuneConstitute = {
			22,
			6
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000111
		},
		AllSoulFightBuff = {
			302021
		}
	},
	{
		Id = 12,
		RuneConstitute = {
			23,
			24
		},
		ConstituteNum = {
			6,
			6
		},
		Buff = {
			100000112
		},
		SoulTeamFightBuff = {
			302031
		}
	}
}

setmetatable(CfgLegendConstituteTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLegendConstituteTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ConstituteNum = {},
		AllSoulFightBuff = {},
		MonsterTeamFightBuff = {},
		AllMonsterFightBuff = {},
		SoulTeamFightBuff = {},
		Buff = {},
		RuneConstitute = {}
	}
}

for i, data in pairs(CfgLegendConstituteTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLegendConstituteTable
