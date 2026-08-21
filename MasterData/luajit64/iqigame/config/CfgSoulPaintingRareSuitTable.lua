-- chunkname: @IQIGame\\Config\\CfgSoulPaintingRareSuitTable.lua

local CfgSoulPaintingRareSuitTable = {
	{
		Quality = 2,
		Id = 1,
		Name = getI18NValue(180128434),
		Desc = getI18NValue(180128433),
		PabilityID = {
			30601001,
			30601002
		}
	},
	{
		Quality = 3,
		Id = 2,
		Name = getI18NValue(180128436),
		Desc = getI18NValue(180128435),
		PabilityID = {
			30601001,
			30601002,
			30601003,
			30602001
		}
	},
	{
		Quality = 4,
		Id = 3,
		Name = getI18NValue(180128438),
		Desc = getI18NValue(180128437),
		PabilityID = {
			30601001,
			30601002,
			30601003,
			30602001,
			30602002,
			30602003
		}
	},
	{
		Quality = 5,
		Id = 4,
		Name = getI18NValue(180128440),
		Desc = getI18NValue(180128439),
		PabilityID = {
			30601001,
			30601002,
			30601003,
			30602001,
			30602002,
			30602003,
			30603001,
			30603002
		}
	},
	{
		Id = 5,
		Quality = 6,
		PabilityID = {
			30601001,
			30601002,
			30601003,
			30602001,
			30602002,
			30602003,
			30603001,
			30603002
		}
	}
}

setmetatable(CfgSoulPaintingRareSuitTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSoulPaintingRareSuitTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Quality = 0,
		Name = "",
		Desc = "",
		PabilityID = {}
	}
}

for i, data in pairs(CfgSoulPaintingRareSuitTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSoulPaintingRareSuitTable
