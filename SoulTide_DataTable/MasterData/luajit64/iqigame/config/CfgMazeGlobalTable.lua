-- chunkname: @IQIGame\\Config\\CfgMazeGlobalTable.lua

local CfgMazeGlobalTable = {
	[1001] = {
		Id = 1001,
		Parameter = "2.7"
	},
	[1002] = {
		Id = 1002,
		Parameter = "2.1|1"
	},
	[1003] = {
		Id = 1003,
		Parameter = "99999"
	},
	[1004] = {
		Id = 1004,
		Parameter = "106|114"
	},
	[1005] = {
		Id = 1005,
		Parameter = "106|188|191|162"
	}
}

setmetatable(CfgMazeGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMazeGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Parameter = ""
	}
}

for i, data in pairs(CfgMazeGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMazeGlobalTable
