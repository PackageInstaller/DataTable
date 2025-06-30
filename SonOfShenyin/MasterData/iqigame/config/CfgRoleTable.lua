-- chunkname: @IQIGame\\Config\\CfgRoleTable.lua

local CfgRoleTable = {
	[1000] = {
		Id = 1000,
		Name = "冒险者"
	}
}

setmetatable(CfgRoleTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRoleTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = ""
	}
}

for i, data in pairs(CfgRoleTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRoleTable
