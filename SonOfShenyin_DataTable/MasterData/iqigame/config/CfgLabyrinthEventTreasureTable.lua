-- chunkname: @IQIGame\\Config\\CfgLabyrinthEventTreasureTable.lua

local CfgLabyrinthEventTreasureTable = {
	[41800001] = {
		TreasureShow = 10815061,
		Id = 41800001,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901001,
			41901002,
			41901003
		},
		Text = getI18NValue(180196758)
	},
	[41800002] = {
		TreasureShow = 10815061,
		Id = 41800002,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901004,
			41901005,
			41901006
		},
		Text = getI18NValue(180196759)
	},
	[41800003] = {
		TreasureShow = 10815061,
		Id = 41800003,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901007,
			41901008,
			41901009
		},
		Text = getI18NValue(180196760)
	},
	[41800004] = {
		TreasureShow = 10815061,
		Id = 41800004,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901010,
			41901011,
			41901012
		},
		Text = getI18NValue(180196761)
	},
	[41800005] = {
		TreasureShow = 10815061,
		Id = 41800005,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901013,
			41901014,
			41901015
		},
		Text = getI18NValue(180196762)
	},
	[41800006] = {
		TreasureShow = 10815061,
		Id = 41800006,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901016,
			41901017,
			41901018
		},
		Text = getI18NValue(180196763)
	},
	[41800007] = {
		TreasureShow = 10815061,
		Id = 41800007,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901019,
			41901020,
			41901021
		},
		Text = getI18NValue(180196764)
	},
	[41800008] = {
		TreasureShow = 10815061,
		Id = 41800008,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901022,
			41901023,
			41901024
		},
		Text = getI18NValue(180196765)
	},
	[41800009] = {
		TreasureShow = 10815061,
		Id = 41800009,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901029
		},
		Text = getI18NValue(180196922)
	},
	[41800010] = {
		TreasureShow = 10815061,
		Id = 41800010,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901030
		},
		Text = getI18NValue(180196926)
	},
	[41800011] = {
		TreasureShow = 10815064,
		Id = 41800011,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901029
		},
		Text = getI18NValue(180197684)
	},
	[41801001] = {
		TreasureShow = 10815064,
		Id = 41801001,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901022,
			41901023,
			41901024
		},
		Text = getI18NValue(180196918)
	},
	[41802001] = {
		TreasureShow = 10815064,
		Id = 41802001,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901031
		},
		Text = getI18NValue(180196953)
	},
	[41802002] = {
		TreasureShow = 10815064,
		Id = 41802002,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901032
		},
		Text = getI18NValue(180196954)
	},
	[41802003] = {
		TreasureShow = 10815064,
		Id = 41802003,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901033
		},
		Text = getI18NValue(180196955)
	},
	[41802004] = {
		TreasureShow = 10815064,
		Id = 41802004,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901034
		},
		Text = getI18NValue(180196956)
	},
	[41802005] = {
		TreasureShow = 10815064,
		Id = 41802005,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901035
		},
		Text = getI18NValue(180196957)
	},
	[41802006] = {
		TreasureShow = 10815064,
		Id = 41802006,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901036
		},
		Text = getI18NValue(180196958)
	},
	[41803001] = {
		TreasureShow = 10815064,
		Id = 41803001,
		DefaultAnimation = "S_off",
		DefaultEffect = {
			10027,
			10001
		},
		mutualIds = {
			41901037
		},
		Text = getI18NValue(180220018)
	}
}

setmetatable(CfgLabyrinthEventTreasureTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthEventTreasureTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Text = "",
		TreasureShow = 0,
		DefaultAnimation = "",
		DefaultEffect = {},
		mutualIds = {}
	}
}

for i, data in pairs(CfgLabyrinthEventTreasureTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthEventTreasureTable
