-- chunkname: @IQIGame\\Config\\CfgGalgameMonsterQTETable.lua

local CfgGalgameMonsterQTETable = {
	[1001] = {
		Id = 1001,
		time = 25,
		SucScore = 10,
		BGM = 109,
		Grade = {
			1,
			1
		}
	},
	[1002] = {
		Id = 1002,
		time = 25,
		SucScore = 12,
		BGM = 109,
		Grade = {
			1,
			1
		}
	},
	[1003] = {
		Id = 1003,
		time = 25,
		SucScore = 14,
		BGM = 109,
		Grade = {
			1,
			1
		}
	},
	[1004] = {
		Id = 1004,
		time = 25,
		SucScore = 16,
		BGM = 109,
		Grade = {
			1,
			1
		}
	},
	[1005] = {
		Id = 1005,
		time = 25,
		SucScore = 18,
		BGM = 109,
		Grade = {
			1,
			1
		}
	},
	[1006] = {
		Id = 1006,
		time = 25,
		SucScore = 20,
		BGM = 109,
		Grade = {
			1,
			1
		}
	},
	[1007] = {
		Id = 1007,
		time = 40,
		SucScore = 30,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1008] = {
		Id = 1008,
		time = 40,
		SucScore = 35,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1009] = {
		Id = 1009,
		time = 40,
		SucScore = 40,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1010] = {
		Id = 1010,
		time = 40,
		SucScore = 45,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1011] = {
		Id = 1011,
		time = 40,
		SucScore = 50,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1012] = {
		Id = 1012,
		time = 40,
		SucScore = 55,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1013] = {
		Id = 1013,
		time = 50,
		SucScore = 50,
		BGM = 109,
		Grade = {
			1,
			3
		}
	},
	[1014] = {
		Id = 1014,
		time = 50,
		SucScore = 60,
		BGM = 109,
		Grade = {
			1,
			3
		}
	},
	[1015] = {
		Id = 1015,
		time = 50,
		SucScore = 70,
		BGM = 109,
		Grade = {
			1,
			3
		}
	},
	[1016] = {
		Id = 1016,
		time = 50,
		SucScore = 80,
		BGM = 109,
		Grade = {
			1,
			3
		}
	},
	[1017] = {
		Id = 1017,
		time = 50,
		SucScore = 90,
		BGM = 109,
		Grade = {
			1,
			3
		}
	},
	[1018] = {
		Id = 1018,
		time = 50,
		SucScore = 100,
		BGM = 109,
		Grade = {
			1,
			3
		}
	},
	[1019] = {
		Id = 1019,
		time = 60,
		SucScore = 100,
		BGM = 109,
		Grade = {
			1,
			4
		}
	},
	[1020] = {
		Id = 1020,
		time = 60,
		SucScore = 110,
		BGM = 109,
		Grade = {
			1,
			4
		}
	},
	[1021] = {
		Id = 1021,
		time = 60,
		SucScore = 120,
		BGM = 109,
		Grade = {
			1,
			4
		}
	},
	[1022] = {
		Id = 1022,
		time = 60,
		SucScore = 130,
		BGM = 109,
		Grade = {
			1,
			4
		}
	},
	[1023] = {
		Id = 1023,
		time = 60,
		SucScore = 140,
		BGM = 109,
		Grade = {
			1,
			4
		}
	},
	[1024] = {
		Id = 1024,
		time = 60,
		SucScore = 150,
		BGM = 109,
		Grade = {
			1,
			4
		}
	},
	[1501] = {
		Id = 1501,
		time = 60,
		SucScore = 50,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1511] = {
		Id = 1511,
		time = 60,
		SucScore = 50,
		BGM = 109,
		Grade = {
			1,
			2
		}
	},
	[1601] = {
		Id = 1601,
		time = 60,
		SucScore = 50,
		BGM = 109,
		Grade = {
			1,
			2
		}
	}
}

setmetatable(CfgGalgameMonsterQTETable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGalgameMonsterQTETable]")
	end
})

local defaultMetaTable = {
	__index = {
		time = 0,
		SucScore = 0,
		BGM = 0,
		Grade = {},
		Reward = {},
		Cost = {}
	}
}

for i, data in pairs(CfgGalgameMonsterQTETable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGalgameMonsterQTETable
