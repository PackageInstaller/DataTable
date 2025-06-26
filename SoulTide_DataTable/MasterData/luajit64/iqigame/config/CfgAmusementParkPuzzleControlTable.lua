-- chunkname: @IQIGame\\Config\\CfgAmusementParkPuzzleControlTable.lua

local CfgAmusementParkPuzzleControlTable = {
	{
		Group = 1,
		Id = 1,
		Level = 1,
		BlockNum = 4,
		Score = {
			100,
			300,
			600,
			1000,
			1500,
			2000,
			3000
		},
		BlockGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			14,
			20,
			21
		},
		BuildingLevel = {
			16,
			1
		}
	},
	{
		Group = 1,
		Id = 2,
		Level = 2,
		BlockNum = 4,
		Score = {
			100,
			300,
			600,
			1000,
			1500,
			2000,
			3000
		},
		BlockGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			12,
			13,
			14,
			15,
			16,
			20,
			21,
			24,
			25,
			26,
			27
		},
		BuildingLevel = {
			16,
			5
		}
	},
	{
		Group = 1,
		Id = 3,
		Level = 3,
		BlockNum = 4,
		Score = {
			100,
			300,
			600,
			1000,
			1500,
			2000,
			3000
		},
		BlockGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25,
			26,
			27
		},
		BuildingLevel = {
			16,
			10
		}
	}
}

setmetatable(CfgAmusementParkPuzzleControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkPuzzleControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Level = 0,
		BlockNum = 0,
		Score = {},
		BuildingLevel = {},
		BlockGroup = {}
	}
}

for i, data in pairs(CfgAmusementParkPuzzleControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkPuzzleControlTable
