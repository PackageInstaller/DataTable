-- chunkname: @IQIGame\\Config\\CfgVariationTable.lua

local CfgVariationTable = {
	[10001] = {
		Scale = 2,
		Id = 10001,
		HeroSkin = 10400201,
		InitialBuff = {
			1800
		},
		RemoveSkills = {
			100510,
			100520,
			100530
		},
		AddSkill = {
			{
				100210,
				100510,
				100510,
				100510
			},
			{
				100220,
				100520,
				100520,
				100520
			},
			{
				100230,
				100530,
				100530,
				100530
			},
			{},
			{},
			{},
			{}
		}
	},
	[20001] = {
		Id = 20001,
		HeroSkin = 10401101,
		Scale = 2
	},
	[33803] = {
		Id = 33803,
		HeroSkin = 10450033,
		Scale = 2
	},
	[34803] = {
		Id = 34803,
		HeroSkin = 10450038,
		Scale = 2
	},
	[36802] = {
		Id = 36802,
		HeroSkin = 10452016,
		Scale = 2
	}
}

setmetatable(CfgVariationTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgVariationTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Scale = 0,
		HeroSkin = 0,
		InitialBuff = {},
		AddSkill = {
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		},
		RemoveSkills = {}
	}
}

for i, data in pairs(CfgVariationTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgVariationTable
