-- chunkname: @IQIGame\\Config\\CfgEvilErosionDailySupplyTable.lua

local CfgEvilErosionDailySupplyTable = {
	[1001] = {
		Day = 1,
		Group = 1,
		Id = 1001,
		Items = {
			210,
			500
		}
	},
	[1002] = {
		Day = 2,
		Group = 1,
		Id = 1002,
		Items = {
			210,
			500
		}
	},
	[1003] = {
		Day = 3,
		Group = 1,
		Id = 1003,
		Items = {
			210,
			500
		}
	},
	[1004] = {
		Day = 4,
		Group = 1,
		Id = 1004,
		Items = {
			210,
			500
		}
	},
	[1005] = {
		Day = 5,
		Group = 1,
		Id = 1005,
		Items = {
			210,
			500
		}
	},
	[1006] = {
		Day = 6,
		Group = 1,
		Id = 1006,
		Items = {
			210,
			500
		}
	},
	[1007] = {
		Day = 7,
		Group = 1,
		Id = 1007,
		Items = {
			210,
			500
		}
	},
	[1008] = {
		Day = 8,
		Group = 1,
		Id = 1008,
		Items = {
			210,
			500
		}
	},
	[1009] = {
		Day = 9,
		Group = 1,
		Id = 1009,
		Items = {
			210,
			500
		}
	},
	[1010] = {
		Day = 10,
		Group = 1,
		Id = 1010,
		Items = {
			210,
			500
		}
	},
	[1011] = {
		Day = 11,
		Group = 1,
		Id = 1011,
		Items = {
			210,
			500
		}
	},
	[1012] = {
		Day = 12,
		Group = 1,
		Id = 1012,
		Items = {
			210,
			500
		}
	},
	[1013] = {
		Day = 13,
		Group = 1,
		Id = 1013,
		Items = {
			210,
			500
		}
	},
	[1014] = {
		Day = 14,
		Group = 1,
		Id = 1014,
		Items = {
			210,
			500
		}
	},
	[1015] = {
		Day = 15,
		Group = 1,
		Id = 1015,
		Items = {
			210,
			500
		}
	},
	[1016] = {
		Day = 16,
		Group = 1,
		Id = 1016,
		Items = {
			210,
			500
		}
	},
	[1017] = {
		Day = 17,
		Group = 1,
		Id = 1017,
		Items = {
			210,
			500
		}
	},
	[1018] = {
		Day = 18,
		Group = 1,
		Id = 1018,
		Items = {
			210,
			500
		}
	},
	[1019] = {
		Day = 19,
		Group = 1,
		Id = 1019,
		Items = {
			210,
			500
		}
	},
	[1020] = {
		Day = 20,
		Group = 1,
		Id = 1020,
		Items = {
			210,
			500
		}
	},
	[1021] = {
		Day = 21,
		Group = 1,
		Id = 1021,
		Items = {
			210,
			500
		}
	},
	[1022] = {
		Day = 22,
		Group = 1,
		Id = 1022,
		Items = {
			210,
			500
		}
	},
	[1023] = {
		Day = 23,
		Group = 1,
		Id = 1023,
		Items = {
			210,
			500
		}
	},
	[1024] = {
		Day = 24,
		Group = 1,
		Id = 1024,
		Items = {
			210,
			500
		}
	},
	[1025] = {
		Day = 25,
		Group = 1,
		Id = 1025,
		Items = {
			210,
			500
		}
	},
	[1026] = {
		Day = 26,
		Group = 1,
		Id = 1026,
		Items = {
			210,
			500
		}
	},
	[1027] = {
		Day = 27,
		Group = 1,
		Id = 1027,
		Items = {
			210,
			500
		}
	},
	[1028] = {
		Day = 28,
		Group = 1,
		Id = 1028,
		Items = {
			210,
			500
		}
	},
	[1029] = {
		Day = 29,
		Group = 1,
		Id = 1029,
		Items = {
			210,
			500
		}
	},
	[1030] = {
		Day = 30,
		Group = 1,
		Id = 1030,
		Items = {
			210,
			500
		}
	},
	[1031] = {
		Day = 31,
		Group = 1,
		Id = 1031,
		Items = {
			210,
			500
		}
	}
}

setmetatable(CfgEvilErosionDailySupplyTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEvilErosionDailySupplyTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Day = 0,
		Items = {}
	}
}

for i, data in pairs(CfgEvilErosionDailySupplyTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEvilErosionDailySupplyTable
