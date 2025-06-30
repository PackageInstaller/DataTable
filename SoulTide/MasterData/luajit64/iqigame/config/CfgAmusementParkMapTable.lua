-- chunkname: @IQIGame\\Config\\CfgAmusementParkMapTable.lua

local CfgAmusementParkMapTable = {
	{
		Group = 1,
		MapPrefab = "ART_Prefabs/Scene/AmusementPark/Map/Map_01/Map_01.prefab",
		Id = 1,
		MaxSize = {
			5,
			5
		},
		DefaultBuildingPos = {
			1,
			13
		},
		UnlockBuildingLevel = {
			1,
			4,
			5,
			7,
			9
		},
		UnlockSquare = {
			{
				7,
				8,
				9,
				12,
				13,
				14,
				17,
				18,
				19
			},
			{
				7,
				8,
				9,
				12,
				13,
				14,
				17,
				18,
				19,
				10,
				15,
				20
			},
			{
				7,
				8,
				9,
				12,
				13,
				14,
				17,
				18,
				19,
				10,
				15,
				20,
				22,
				23,
				24,
				25
			},
			{
				7,
				8,
				9,
				12,
				13,
				14,
				17,
				18,
				19,
				10,
				15,
				20,
				22,
				23,
				24,
				25,
				21,
				16,
				11,
				6
			},
			{
				7,
				8,
				9,
				12,
				13,
				14,
				17,
				18,
				19,
				22,
				23,
				24,
				6,
				11,
				16,
				21,
				10,
				15,
				20,
				25,
				1,
				2,
				3,
				4,
				5
			}
		}
	}
}

setmetatable(CfgAmusementParkMapTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkMapTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		MapPrefab = "",
		UnlockBuildingLevel = {
			0,
			0,
			0,
			0,
			0
		},
		DefaultBuildingPos = {},
		UnlockSquare = {
			{},
			{},
			{},
			{},
			{}
		},
		MaxSize = {}
	}
}

for i, data in pairs(CfgAmusementParkMapTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkMapTable
