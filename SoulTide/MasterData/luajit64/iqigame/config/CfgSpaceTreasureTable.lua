-- chunkname: @IQIGame\\Config\\CfgSpaceTreasureTable.lua

local CfgSpaceTreasureTable = {
	[1001] = {
		Id = 1001,
		ChapterId = 25011001,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128783),
			getI18NValue(180128784),
			getI18NValue(180128785),
			getI18NValue(180128786)
		}
	},
	[2001] = {
		Id = 2001,
		ChapterId = 25011002,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128787),
			getI18NValue(180128788),
			getI18NValue(180128789),
			getI18NValue(180128790)
		}
	},
	[3001] = {
		Id = 3001,
		ChapterId = 25011003,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128791),
			getI18NValue(180128792),
			getI18NValue(180128793),
			getI18NValue(180128794)
		}
	},
	[4001] = {
		Id = 4001,
		ChapterId = 25011004,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128795),
			getI18NValue(180128796),
			getI18NValue(180128797),
			getI18NValue(180128798)
		}
	},
	[5001] = {
		Id = 5001,
		ChapterId = 25011005,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128799),
			getI18NValue(180128800),
			getI18NValue(180128801),
			getI18NValue(180128802)
		}
	},
	[6001] = {
		Id = 6001,
		ChapterId = 25011006,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128803),
			getI18NValue(180128804),
			getI18NValue(180128805),
			getI18NValue(180128806)
		}
	},
	[7001] = {
		Id = 7001,
		ChapterId = 25011007,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128807),
			getI18NValue(180128808),
			getI18NValue(180128809),
			getI18NValue(180128810)
		}
	},
	[8001] = {
		Id = 8001,
		ChapterId = 25011008,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128811),
			getI18NValue(180128812),
			getI18NValue(180128813),
			getI18NValue(180128814)
		}
	},
	[9001] = {
		Id = 9001,
		ChapterId = 25011009,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128815),
			getI18NValue(180128816),
			getI18NValue(180128817),
			getI18NValue(180128818)
		}
	},
	[10001] = {
		Id = 10001,
		ChapterId = 25011010,
		ExchangeId = {
			61001,
			61002,
			61003,
			61004
		},
		Desc = {
			getI18NValue(180128819),
			getI18NValue(180128820),
			getI18NValue(180128821),
			getI18NValue(180128822)
		}
	}
}

setmetatable(CfgSpaceTreasureTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSpaceTreasureTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ChapterId = 0,
		Desc = {},
		ExchangeId = {}
	}
}

for i, data in pairs(CfgSpaceTreasureTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSpaceTreasureTable
