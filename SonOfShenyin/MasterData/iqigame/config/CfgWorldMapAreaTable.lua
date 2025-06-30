-- chunkname: @IQIGame\\Config\\CfgWorldMapAreaTable.lua

local CfgWorldMapAreaTable = {
	[10100] = {
		MapName = "事务所",
		Id = 10100,
		IsDefault = true,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216653),
			""
		}
	},
	[10200] = {
		MapName = "流放之街",
		Id = 10200,
		WeatherImg = "2",
		NameCondition = {
			30000461,
			30000432
		},
		Name = {
			getI18NValue(180216655),
			getI18NValue(180216654)
		},
		UnlockCondition = {
			30000431
		}
	},
	[10300] = {
		MapName = "商业街",
		Id = 10300,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216656),
			""
		},
		UnlockCondition = {
			30000433
		}
	},
	[10400] = {
		MapName = "旧城区",
		Id = 10400,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216657),
			""
		},
		UnlockCondition = {
			30000434
		}
	},
	[10500] = {
		MapName = "集市",
		Id = 10500,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216658),
			""
		},
		UnlockCondition = {
			30000435
		}
	},
	[10600] = {
		MapName = "天成学院",
		Id = 10600,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216659),
			""
		},
		UnlockCondition = {
			30000416
		}
	},
	[10800] = {
		MapName = "平安院",
		Id = 10800,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216660),
			""
		},
		UnlockCondition = {
			30000417
		}
	},
	[10900] = {
		MapName = "菏泽村",
		Id = 10900,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216661),
			""
		},
		UnlockCondition = {
			30000418
		}
	},
	[11000] = {
		MapName = "文月家",
		Id = 11000,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216662),
			""
		},
		UnlockCondition = {
			30000419
		}
	},
	[11100] = {
		MapName = "夜首山",
		Id = 11100,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180216663),
			""
		},
		UnlockCondition = {
			30000420
		}
	},
	[20100] = {
		MapName = "活动专属区域",
		Id = 20100,
		IsDefault = false,
		WeatherImg = "2",
		Name = {
			getI18NValue(180261618),
			""
		},
		UnlockCondition = {
			30000000
		}
	}
}

setmetatable(CfgWorldMapAreaTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWorldMapAreaTable]")
	end
})

local defaultMetaTable = {
	__index = {
		MapName = "",
		WeatherImg = "",
		IsDefault = false,
		CloudMask = "",
		PartLocation = 0,
		NameCondition = {
			0,
			0
		},
		UnlockCondition = {},
		Name = {
			"",
			""
		}
	}
}

for i, data in pairs(CfgWorldMapAreaTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWorldMapAreaTable
