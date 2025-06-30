-- chunkname: @IQIGame\\Config\\CfgScreenPerformanceTable.lua

local CfgScreenPerformanceTable = {
	[39300000] = {
		Id = 39300000,
		PerformanceType = 1,
		PerformanceParameter = {
			"1",
			"1"
		}
	},
	[39300001] = {
		Id = 39300001,
		PerformanceType = 1,
		PerformanceParameter = {
			"0.5",
			"0.7"
		}
	},
	[39300002] = {
		Id = 39300002,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001701",
			"0",
			"0",
			"6"
		}
	},
	[39300003] = {
		Id = 39300003,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001702",
			"0",
			"0",
			"4"
		}
	},
	[39300004] = {
		Id = 39300004,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001703",
			"0",
			"0",
			"4"
		}
	},
	[39300005] = {
		Id = 39300005,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001710",
			"0",
			"0",
			"4"
		}
	},
	[39300006] = {
		Id = 39300006,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001711",
			"0",
			"0",
			"4"
		}
	},
	[39300007] = {
		Id = 39300007,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001717",
			"0",
			"0",
			"4"
		}
	},
	[39300008] = {
		Id = 39300008,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001717",
			"0",
			"0",
			"4"
		}
	},
	[39300009] = {
		Id = 39300009,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001717",
			"0",
			"0",
			"4"
		}
	},
	[39300010] = {
		Id = 39300010,
		PerformanceType = 1,
		PerformanceParameter = {
			"10",
			"1"
		}
	},
	[39300011] = {
		Id = 39300011,
		PerformanceType = 1,
		PerformanceParameter = {
			"1",
			"0.2"
		}
	},
	[39300012] = {
		Id = 39300012,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001712",
			"0",
			"0",
			"6"
		}
	},
	[39300013] = {
		Id = 39300013,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001713",
			"0",
			"0",
			"6"
		}
	},
	[39300014] = {
		Id = 39300014,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001714",
			"0",
			"0",
			"6"
		}
	},
	[39300015] = {
		Id = 39300015,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001716",
			"0",
			"0",
			"4"
		}
	},
	[39300016] = {
		Id = 39300016,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001715",
			"-300",
			"-80",
			"4"
		}
	},
	[39300017] = {
		Id = 39300017,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001718",
			"0",
			"0",
			"6"
		}
	},
	[39300018] = {
		Id = 39300018,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001719",
			"0",
			"0",
			"4"
		}
	},
	[39300019] = {
		Id = 39300019,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001720",
			"0",
			"0",
			"4"
		}
	},
	[39300020] = {
		Id = 39300020,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001722",
			"0",
			"0",
			"4"
		}
	},
	[39300021] = {
		Id = 39300021,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001723",
			"0",
			"0",
			"6"
		}
	},
	[39300022] = {
		Id = 39300022,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001724",
			"0",
			"0",
			"6"
		}
	},
	[39300023] = {
		Id = 39300023,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001725",
			"0",
			"0",
			"6"
		}
	},
	[39300024] = {
		Id = 39300024,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001728",
			"0",
			"0",
			"4"
		}
	},
	[39300025] = {
		Id = 39300025,
		PerformanceType = 1,
		PerformanceParameter = {
			"30",
			"0.1"
		}
	},
	[39300026] = {
		Id = 39300026,
		PerformanceType = 2,
		PerformanceParameter = {
			"9000930",
			"0",
			"0",
			"4"
		}
	},
	[39300027] = {
		Id = 39300027,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001730",
			"-300",
			"-80",
			"4"
		}
	},
	[39300028] = {
		Id = 39300028,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001304",
			"-300",
			"-250",
			"4"
		}
	},
	[39300029] = {
		Id = 39300029,
		PerformanceType = 2,
		PerformanceParameter = {
			"9001733",
			"650",
			"-700",
			"4"
		}
	}
}

setmetatable(CfgScreenPerformanceTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgScreenPerformanceTable]")
	end
})

local defaultMetaTable = {
	__index = {
		PerformanceType = 0,
		PerformanceParameter = {}
	}
}

for i, data in pairs(CfgScreenPerformanceTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgScreenPerformanceTable
