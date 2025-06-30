-- chunkname: @IQIGame\\Config\\CfgDupIntegralAwardTable.lua

local CfgDupIntegralAwardTable = {
	[202001] = {
		Id = 202001,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			20000,
			17000,
			13600,
			9600,
			5000
		},
		Coefficient = {
			1.08,
			1.2,
			1.36,
			1.6,
			1.84
		}
	},
	[202002] = {
		Id = 202002,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			22000,
			18700,
			14960,
			10560,
			5500
		},
		Coefficient = {
			1.188,
			1.32,
			1.496,
			1.76,
			2.024
		}
	},
	[202003] = {
		Id = 202003,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			24000,
			20400,
			16320,
			11520,
			6000
		},
		Coefficient = {
			1.296,
			1.44,
			1.632,
			1.92,
			2.208
		}
	},
	[202004] = {
		Id = 202004,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			26000,
			22100,
			17680,
			12480,
			6500
		},
		Coefficient = {
			1.404,
			1.56,
			1.768,
			2.08,
			2.392
		}
	},
	[202005] = {
		Id = 202005,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			28000,
			23800,
			19040,
			13440,
			7000
		},
		Coefficient = {
			1.512,
			1.68,
			1.904,
			2.24,
			2.576
		}
	},
	[202006] = {
		Id = 202006,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			30000,
			25500,
			20400,
			14400,
			7500
		},
		Coefficient = {
			1.62,
			1.8,
			2.04,
			2.4,
			2.76
		}
	},
	[202007] = {
		Id = 202007,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			32000,
			27200,
			21760,
			15360,
			8000
		},
		Coefficient = {
			1.728,
			1.92,
			2.176,
			2.56,
			2.944
		}
	},
	[202008] = {
		Id = 202008,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			34000,
			28900,
			23120,
			16320,
			8500
		},
		Coefficient = {
			1.836,
			2.04,
			2.312,
			2.72,
			3.128
		}
	},
	[202009] = {
		Id = 202009,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			36000,
			30600,
			24480,
			17280,
			9000
		},
		Coefficient = {
			1.944,
			2.16,
			2.448,
			2.88,
			3.312
		}
	},
	[202010] = {
		Id = 202010,
		AwardID = 4,
		Integral = {
			10000,
			7500,
			5000,
			2500
		},
		Guaranteed = {
			40000,
			34000,
			27200,
			19200,
			10000
		},
		Coefficient = {
			2.16,
			2.4,
			2.72,
			3.2,
			3.68
		}
	}
}

setmetatable(CfgDupIntegralAwardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDupIntegralAwardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		AwardID = 0,
		Coefficient = {},
		Integral = {},
		Guaranteed = {}
	}
}

for i, data in pairs(CfgDupIntegralAwardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDupIntegralAwardTable
