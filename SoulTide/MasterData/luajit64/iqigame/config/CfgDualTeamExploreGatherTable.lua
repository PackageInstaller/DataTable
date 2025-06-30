-- chunkname: @IQIGame\\Config\\CfgDualTeamExploreGatherTable.lua

local CfgDualTeamExploreGatherTable = {}

setmetatable(CfgDualTeamExploreGatherTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDualTeamExploreGatherTable]")
	end
})

local defaultMetaTable = {
	__index = {}
}

for i, data in pairs(CfgDualTeamExploreGatherTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDualTeamExploreGatherTable
