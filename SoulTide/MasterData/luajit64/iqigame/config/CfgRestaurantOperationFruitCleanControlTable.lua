-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationFruitCleanControlTable.lua

local CfgRestaurantOperationFruitCleanControlTable = {
	{
		Group = 1,
		Id = 1,
		Level = 1,
		Countdown = 6,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			4,
			10
		}
	},
	{
		Group = 1,
		Id = 2,
		Level = 2,
		Countdown = 6,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			4,
			12
		}
	},
	{
		Group = 1,
		Id = 3,
		Level = 3,
		Countdown = 6,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			4,
			14
		}
	},
	{
		Group = 1,
		Id = 4,
		Level = 4,
		Countdown = 6,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			5,
			10
		}
	},
	{
		Group = 1,
		Id = 5,
		Level = 5,
		Countdown = 5,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			5,
			10
		}
	},
	{
		Group = 1,
		Id = 6,
		Level = 6,
		Countdown = 5,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			5,
			12
		}
	},
	{
		Group = 1,
		Id = 7,
		Level = 7,
		Countdown = 5,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			6,
			8
		}
	},
	{
		Group = 1,
		Id = 8,
		Level = 8,
		Countdown = 4,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			7,
			8
		}
	},
	{
		Group = 1,
		Id = 9,
		Level = 9,
		Countdown = 4,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			9,
			6
		}
	},
	{
		Group = 1,
		Id = 10,
		Level = 10,
		Countdown = 4,
		FruitGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		FruitComposition = {
			10,
			6
		}
	}
}

setmetatable(CfgRestaurantOperationFruitCleanControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationFruitCleanControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Level = 0,
		Countdown = 0,
		FruitComposition = {},
		FruitGroup = {}
	}
}

for i, data in pairs(CfgRestaurantOperationFruitCleanControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationFruitCleanControlTable
