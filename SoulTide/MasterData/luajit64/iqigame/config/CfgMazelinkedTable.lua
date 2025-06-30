-- chunkname: @IQIGame\\Config\\CfgMazelinkedTable.lua

local CfgMazelinkedTable = {}

setmetatable(CfgMazelinkedTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMazelinkedTable]")
	end
})

local defaultMetaTable = {
	__index = {}
}

for i, data in pairs(CfgMazelinkedTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMazelinkedTable
