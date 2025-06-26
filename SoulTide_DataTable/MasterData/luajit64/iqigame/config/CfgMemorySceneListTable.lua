-- chunkname: @IQIGame\\Config\\CfgMemorySceneListTable.lua

local CfgMemorySceneListTable = {
	[1001] = {
		Id = 1001,
		Name = "白日做梦",
		Direction = true,
		ScenePrefab = "/Scene/Memory/Map_10000.prefab",
		AmbientSound = 10125,
		BGM = 20,
		BornPoint = {
			-10.57,
			-3.34
		},
		EventList = {
			10101,
			10102,
			10103
		}
	}
}

setmetatable(CfgMemorySceneListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMemorySceneListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BGM = 0,
		Name = "",
		Direction = false,
		ScenePrefab = "",
		AmbientSound = 0,
		EventList = {},
		BornPoint = {}
	}
}

for i, data in pairs(CfgMemorySceneListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMemorySceneListTable
