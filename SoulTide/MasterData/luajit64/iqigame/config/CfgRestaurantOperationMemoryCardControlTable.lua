-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationMemoryCardControlTable.lua

local CfgRestaurantOperationMemoryCardControlTable = {
	{
		Id = 1,
		Level = 1,
		Countdown = 40,
		CardGroup = {
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
			12
		},
		CardComposition = {
			2,
			12
		},
		LevelDes = getI18NValue(180831870)
	},
	{
		Id = 2,
		Level = 2,
		Countdown = 50,
		CardGroup = {
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
			12
		},
		CardComposition = {
			3,
			8
		},
		LevelDes = getI18NValue(180831871)
	},
	{
		Id = 3,
		Level = 3,
		Countdown = 60,
		CardGroup = {
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
			12
		},
		CardComposition = {
			4,
			6
		},
		LevelDes = getI18NValue(180831872)
	},
	{
		Id = 4,
		Level = 4,
		Countdown = 70,
		CardGroup = {
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
			12
		},
		CardComposition = {
			5,
			4,
			2,
			2
		},
		LevelDes = getI18NValue(180831873)
	},
	{
		Id = 5,
		Level = 5,
		Countdown = 80,
		CardGroup = {
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
			12
		},
		CardComposition = {
			6,
			2,
			3,
			4
		},
		LevelDes = getI18NValue(180831874)
	},
	{
		Id = 6,
		Level = 6,
		Countdown = 90,
		CardGroup = {
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
			12
		},
		CardComposition = {
			4,
			4,
			2,
			4
		},
		LevelDes = getI18NValue(180831875)
	},
	{
		Id = 7,
		Level = 7,
		Countdown = 100,
		CardGroup = {
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
			12
		},
		CardComposition = {
			8,
			2,
			2,
			4
		},
		LevelDes = getI18NValue(180831876)
	},
	{
		Id = 8,
		Level = 8,
		Countdown = 110,
		CardGroup = {
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
			12
		},
		CardComposition = {
			9,
			2,
			3,
			2
		},
		LevelDes = getI18NValue(180831877)
	},
	{
		Id = 9,
		Level = 9,
		Countdown = 120,
		CardGroup = {
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
			12
		},
		CardComposition = {
			10,
			2,
			2,
			2
		},
		LevelDes = getI18NValue(180831878)
	},
	{
		Id = 10,
		Level = 10,
		Countdown = 130,
		CardGroup = {
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
			12
		},
		CardComposition = {
			12,
			2
		},
		LevelDes = getI18NValue(180831879)
	}
}

setmetatable(CfgRestaurantOperationMemoryCardControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationMemoryCardControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		LevelDes = "",
		Level = 0,
		Countdown = 0,
		CardComposition = {},
		CardGroup = {}
	}
}

for i, data in pairs(CfgRestaurantOperationMemoryCardControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationMemoryCardControlTable
