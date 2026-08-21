-- chunkname: @IQIGame\\Config\\CfgDropLibMazeFilterTable.lua

local CfgDropLibMazeFilterTable = {}

setmetatable(CfgDropLibMazeFilterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDropLibMazeFilterTable]")
	end
})

local defaultMetaTable = {
	__index = {}
}

for i, data in pairs(CfgDropLibMazeFilterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDropLibMazeFilterTable
