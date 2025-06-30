-- chunkname: @IQIGame\\Config\\CfgAutoTextI18NTable.lua

local CfgAutoTextI18NTable = {}

setmetatable(CfgAutoTextI18NTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAutoTextI18NTable]")
	end
})

local defaultMetaTable = {
	__index = {}
}

for i, data in pairs(CfgAutoTextI18NTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAutoTextI18NTable
