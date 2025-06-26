-- chunkname: @IQIGame\\Config\\CfgElementRestraintTable.lua

local CfgElementRestraintTable = {
	{
		AdvantageDmgAdd = 0.3,
		Element = 1,
		DisadvantageDmgAdd = 0.3,
		Id = 1,
		AdvantageElement = {
			3
		},
		DisadvantageElement = {
			2
		}
	},
	{
		AdvantageDmgAdd = 0.3,
		Element = 2,
		DisadvantageDmgAdd = 0.3,
		Id = 2,
		AdvantageElement = {
			1
		},
		DisadvantageElement = {
			4
		}
	},
	{
		AdvantageDmgAdd = 0.3,
		Element = 3,
		DisadvantageDmgAdd = 0.3,
		Id = 3,
		AdvantageElement = {
			4
		},
		DisadvantageElement = {
			1
		}
	},
	{
		AdvantageDmgAdd = 0.3,
		Element = 4,
		DisadvantageDmgAdd = 0.3,
		Id = 4,
		AdvantageElement = {
			2
		},
		DisadvantageElement = {
			3
		}
	},
	{
		Id = 5
	}
}

setmetatable(CfgElementRestraintTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgElementRestraintTable]")
	end
})

local defaultMetaTable = {
	__index = {
		AdvantageDmgAdd = 0,
		Element = 0,
		DisadvantageDmgAdd = 0,
		AdvantageElement = {},
		DisadvantageElement = {}
	}
}

for i, data in pairs(CfgElementRestraintTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgElementRestraintTable
