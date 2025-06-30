-- chunkname: @IQIGame\\Config\\CfgGroupBuyPackTable.lua

local CfgGroupBuyPackTable = {
	{
		TimesLimit = 3,
		Id = 1,
		payPoint = 648,
		Name = getI18NValue(180079080),
		Reward = {
			10006,
			60,
			10005,
			20
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	},
	{
		TimesLimit = 3,
		Id = 2,
		payPoint = 328,
		Name = getI18NValue(180079081),
		Reward = {
			10006,
			30,
			10005,
			10
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	},
	{
		TimesLimit = 3,
		Id = 3,
		payPoint = 128,
		Name = getI18NValue(180079082),
		Reward = {
			10006,
			10,
			10005,
			5
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	},
	{
		TimesLimit = 1,
		Id = 4,
		payPoint = 128,
		Name = getI18NValue(180079083),
		Reward = {
			10003,
			6,
			20201,
			200
		},
		Discount = {
			{
				0.05,
				1500
			},
			{
				0.1,
				3000
			},
			{
				0.15,
				5000
			},
			{
				0.2,
				7500
			},
			{
				0.3,
				10000
			}
		}
	},
	{
		TimesLimit = 1,
		Id = 5,
		Name = getI18NValue(180079084),
		Reward = {
			10006,
			10
		},
		Price = {
			2,
			2000
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	},
	[11] = {
		TimesLimit = 3,
		Id = 11,
		payPoint = 648,
		Name = getI18NValue(180294947),
		Reward = {
			10006,
			60,
			10005,
			20
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	},
	[12] = {
		TimesLimit = 3,
		Id = 12,
		payPoint = 328,
		Name = getI18NValue(180294948),
		Reward = {
			10006,
			30,
			10005,
			10
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	},
	[13] = {
		TimesLimit = 3,
		Id = 13,
		payPoint = 128,
		Name = getI18NValue(180294949),
		Reward = {
			10006,
			10,
			10005,
			5
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	},
	[14] = {
		TimesLimit = 1,
		Id = 14,
		payPoint = 128,
		Name = getI18NValue(180294950),
		Reward = {
			10003,
			6,
			20201,
			200
		},
		Discount = {
			{
				0.05,
				1500
			},
			{
				0.1,
				3000
			},
			{
				0.15,
				5000
			},
			{
				0.2,
				7500
			},
			{
				0.3,
				10000
			}
		}
	},
	[15] = {
		TimesLimit = 1,
		Id = 15,
		Name = getI18NValue(180294951),
		Reward = {
			10006,
			10
		},
		Price = {
			2,
			2000
		},
		Discount = {
			{
				0.05,
				5000
			},
			{
				0.1,
				10000
			},
			{
				0.15,
				15000
			},
			{
				0.2,
				20000
			},
			{
				0.3,
				30000
			}
		}
	}
}

setmetatable(CfgGroupBuyPackTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGroupBuyPackTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		TimesLimit = 0,
		payPoint = 0,
		Discount = {
			{},
			{},
			{},
			{},
			{}
		},
		Price = {},
		Reward = {}
	}
}

for i, data in pairs(CfgGroupBuyPackTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGroupBuyPackTable
