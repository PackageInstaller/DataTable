-- chunkname: @IQIGame\\Config\\CfgLabyrinthMarketLevelTable.lua

local CfgLabyrinthMarketLevelTable = {
	[40020001] = {
		Id = 40020001,
		Level = 1,
		ConditionIds = {
			30067001,
			30067011
		},
		NextDisplay = {
			15022,
			50034,
			50032
		},
		LevelDes = getI18NValue(180201991)
	},
	[40020002] = {
		Id = 40020002,
		Level = 2,
		ConditionIds = {
			30067002,
			30067012
		},
		NextDisplay = {
			15022,
			3000,
			3003,
			50034,
			50033,
			50031
		},
		LevelDes = getI18NValue(180201992)
	},
	[40020003] = {
		Id = 40020003,
		Level = 3,
		ConditionIds = {
			30067003,
			30067013
		},
		NextDisplay = {
			15022,
			50033,
			50034,
			50032
		},
		LevelDes = getI18NValue(180201993)
	},
	[40020004] = {
		Id = 40020004,
		Level = 4,
		ConditionIds = {
			30067004,
			30067014
		},
		LevelDes = getI18NValue(180201994)
	},
	[40020005] = {
		Id = 40020005,
		Level = 5
	}
}

setmetatable(CfgLabyrinthMarketLevelTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthMarketLevelTable]")
	end
})

local defaultMetaTable = {
	__index = {
		LevelDes = "",
		Level = 0,
		ConditionIds = {},
		Cost = {},
		NextDisplay = {}
	}
}

for i, data in pairs(CfgLabyrinthMarketLevelTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthMarketLevelTable
