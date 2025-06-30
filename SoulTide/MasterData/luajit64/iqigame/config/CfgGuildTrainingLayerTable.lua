-- chunkname: @IQIGame\\Config\\CfgGuildTrainingLayerTable.lua

local CfgGuildTrainingLayerTable = {
	[100] = {
		BossOrder = 1,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 100,
		Name = getI18NValue(180825864),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260003,
			260004,
			260008,
			260017,
			260019
		},
		ShowAffix = {
			30600003,
			30600004,
			30600007,
			30600012,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[101] = {
		BossOrder = 2,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 101,
		Name = getI18NValue(180825867),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260002,
			260003,
			260012,
			260017,
			260019
		},
		ShowAffix = {
			30600002,
			30600003,
			30600009,
			30600012,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[102] = {
		BossOrder = 3,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 102,
		Name = getI18NValue(180825870),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260004,
			260005,
			260006,
			260016,
			260019
		},
		ShowAffix = {
			30600004,
			30600005,
			30600006,
			30600011,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[103] = {
		BossOrder = 4,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 103,
		Name = getI18NValue(180825873),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260002,
			260004,
			260010,
			260017,
			260019
		},
		ShowAffix = {
			30600002,
			30600004,
			30600008,
			30600012,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[104] = {
		BossOrder = 5,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 104,
		Name = getI18NValue(180835349),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260003,
			260004,
			260014,
			260017,
			260019
		},
		ShowAffix = {
			30600003,
			30600004,
			30600010,
			30600012,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[105] = {
		BossOrder = 6,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 105,
		Name = getI18NValue(180835350),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260003,
			260005,
			260008,
			260016,
			260019
		},
		ShowAffix = {
			30600003,
			30600005,
			30600007,
			30600011,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[106] = {
		BossOrder = 7,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 106,
		Name = getI18NValue(180835351),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260003,
			260001,
			260012,
			260016,
			260019
		},
		ShowAffix = {
			30600003,
			30600001,
			30600009,
			30600011,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[107] = {
		BossOrder = 8,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 107,
		Name = getI18NValue(180835352),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260003,
			260004,
			260006,
			260017,
			260019
		},
		ShowAffix = {
			30600003,
			30600004,
			30600006,
			30600012,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[108] = {
		BossOrder = 9,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 108,
		Name = getI18NValue(180835353),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260004,
			260001,
			260010,
			260016,
			260019
		},
		ShowAffix = {
			30600004,
			30600001,
			30600008,
			30600011,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	},
	[109] = {
		BossOrder = 10,
		PerPointDamage = 10000,
		ElementEntityID = 990110,
		MonsterTeam = 42600101,
		Id = 109,
		Name = getI18NValue(180835354),
		MonsterInfo = {
			42600101
		},
		AffixBuff = {
			260004,
			260001,
			260014,
			260016,
			260019
		},
		ShowAffix = {
			30600004,
			30600001,
			30600010,
			30600011,
			30600013
		},
		WeakType = {
			1,
			2,
			3,
			5,
			6
		}
	}
}

setmetatable(CfgGuildTrainingLayerTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildTrainingLayerTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BossOrder = 0,
		PerPointDamage = 0,
		ElementEntityID = 0,
		MonsterTeam = 0,
		Name = "",
		ShowAffix = {},
		AffixBuff = {},
		MonsterInfo = {},
		WeakType = {}
	}
}

for i, data in pairs(CfgGuildTrainingLayerTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildTrainingLayerTable
