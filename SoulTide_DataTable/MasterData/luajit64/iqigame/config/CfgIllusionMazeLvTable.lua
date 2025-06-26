-- chunkname: @IQIGame\\Config\\CfgIllusionMazeLvTable.lua

local CfgIllusionMazeLvTable = {
	{
		Id = 1,
		Reward = 21001000,
		UnlockInstance = 25020100
	},
	{
		Id = 2,
		UnlockInstance = 25020108,
		Lv = 1,
		Reward = 21001000
	},
	{
		Id = 3,
		UnlockInstance = 25020115,
		Lv = 2,
		Reward = 21001000
	},
	{
		Id = 4,
		UnlockInstance = 25020205,
		Lv = 3,
		Reward = 21003000
	},
	{
		Id = 5,
		UnlockInstance = 25020215,
		Lv = 4,
		Reward = 21003000
	},
	{
		Id = 6,
		UnlockInstance = 25020305,
		Lv = 5,
		Reward = 21005000
	},
	{
		Id = 7,
		UnlockInstance = 25020315,
		Lv = 6,
		Reward = 21005000
	},
	{
		Id = 8,
		UnlockInstance = 25020325,
		Lv = 7,
		Reward = 21005000
	},
	{
		Id = 9,
		UnlockInstance = 25020405,
		Lv = 8,
		Reward = 21008000
	},
	{
		Id = 10,
		UnlockInstance = 25020415,
		Lv = 9,
		Reward = 21008000
	},
	{
		Id = 11,
		UnlockInstance = 25020425,
		Lv = 10,
		Reward = 21008000
	},
	{
		Id = 12,
		UnlockInstance = 25020505,
		Lv = 11,
		Reward = 21011000
	},
	{
		Id = 13,
		UnlockInstance = 25020515,
		Lv = 12,
		Reward = 21011000
	},
	{
		Id = 14,
		UnlockInstance = 25020525,
		Lv = 13,
		Reward = 21011000
	},
	{
		Id = 15,
		UnlockInstance = 25020605,
		Lv = 14,
		Reward = 21014000
	},
	{
		Id = 16,
		UnlockInstance = 25020615,
		Lv = 15,
		Reward = 21014000
	},
	{
		Id = 17,
		UnlockInstance = 25020625,
		Lv = 16,
		Reward = 21014000
	},
	{
		Id = 18,
		UnlockInstance = 25020702,
		Lv = 17,
		Reward = 21017000
	},
	{
		Id = 19,
		UnlockInstance = 25020715,
		Lv = 18,
		Reward = 21017000
	},
	{
		Id = 20,
		UnlockInstance = 25020726,
		Lv = 19,
		Reward = 21017000
	}
}

setmetatable(CfgIllusionMazeLvTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgIllusionMazeLvTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Reward = 0,
		UnlockInstance = 0,
		Lv = 0
	}
}

for i, data in pairs(CfgIllusionMazeLvTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgIllusionMazeLvTable
