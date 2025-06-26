-- chunkname: @IQIGame\\Config\\CfgHomeLandProductionTable.lua

local CfgHomeLandProductionTable = {
	[36100001] = {
		ProduceTime = 300,
		StorageLimit = 100,
		Id = 36100001,
		ProduceItemId = {
			11911
		},
		ProduceItemNum = {
			1
		},
		ProduceItemWeight = {
			1
		},
		ShowItem = {
			11911
		}
	}
}

setmetatable(CfgHomeLandProductionTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLandProductionTable]")
	end
})

local defaultMetaTable = {
	__index = {
		StorageLimit = 0,
		ProduceTime = 0,
		ShowItem = {},
		ProduceItemId = {},
		ProduceItemWeight = {},
		ProduceItemNum = {}
	}
}

for i, data in pairs(CfgHomeLandProductionTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLandProductionTable
