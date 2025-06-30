-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationPuzzleControlTable.lua

local CfgRestaurantOperationPuzzleControlTable = {
	{
		Group = 1,
		Id = 1,
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
			19
		}
	}
}

setmetatable(CfgRestaurantOperationPuzzleControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationPuzzleControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		BlockNum = 0,
		Score = {},
		BlockGroup = {}
	}
}

for i, data in pairs(CfgRestaurantOperationPuzzleControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationPuzzleControlTable
