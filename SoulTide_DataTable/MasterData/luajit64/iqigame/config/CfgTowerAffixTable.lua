-- chunkname: @IQIGame\\Config\\CfgTowerAffixTable.lua

local CfgTowerAffixTable = {}

setmetatable(CfgTowerAffixTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTowerAffixTable]")
	end
})

local defaultMetaTable = {
	__index = {}
}

for i, data in pairs(CfgTowerAffixTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTowerAffixTable
