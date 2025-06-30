-- chunkname: @IQIGame\\Config\\CfgMagicTowerFloorListTable.lua

local CfgMagicTowerFloorListTable = {
	{
		Id = 1,
		BG = "/ART_Prefabs/Scene/MagicTower/Map/MagicTower_Game1_Chapter1.prefab",
		MapType = 1,
		BGM = 418,
		MapData = {
			1,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			1
		},
		CellID = {
			1,
			106,
			401,
			106,
			401,
			106,
			401,
			106,
			401,
			106,
			401,
			106,
			402,
			106,
			2
		}
	},
	{
		Id = 2,
		BG = "/ART_Prefabs/Scene/MagicTower/Map/MagicTower_Game1_Chapter1.prefab",
		MapType = 1,
		BGM = 418,
		MapData = {
			1,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			1
		},
		CellID = {
			1,
			106,
			403,
			106,
			403,
			106,
			403,
			106,
			403,
			106,
			403,
			106,
			404,
			601,
			3
		}
	},
	{
		Id = 3,
		BG = "/ART_Prefabs/Scene/MagicTower/Map/MagicTower_Game1_Chapter1.prefab",
		MapType = 1,
		BGM = 418,
		MapData = {
			1,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			1
		},
		CellID = {
			1,
			106,
			405,
			106,
			405,
			106,
			405,
			106,
			405,
			106,
			405,
			106,
			406,
			106,
			4
		}
	},
	{
		Id = 4,
		BG = "/ART_Prefabs/Scene/MagicTower/Map/MagicTower_Game1_Chapter1.prefab",
		MapType = 1,
		BGM = 418,
		MapData = {
			1,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			1
		},
		CellID = {
			1,
			106,
			407,
			106,
			407,
			106,
			407,
			106,
			407,
			106,
			407,
			106,
			408,
			601,
			5
		}
	},
	{
		Id = 5,
		BG = "/ART_Prefabs/Scene/MagicTower/Map/MagicTower_Game1_Chapter1.prefab",
		MapType = 1,
		BGM = 418,
		MapData = {
			1,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			1
		},
		CellID = {
			1,
			106,
			409,
			106,
			409,
			106,
			409,
			106,
			409,
			106,
			409,
			106,
			410,
			106,
			6
		}
	},
	{
		Id = 6,
		BG = "/ART_Prefabs/Scene/MagicTower/Map/MagicTower_Game1_Chapter1.prefab",
		MapType = 1,
		BGM = 418,
		MapData = {
			1,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			3,
			2,
			1
		},
		CellID = {
			1,
			106,
			411,
			106,
			411,
			106,
			411,
			106,
			411,
			106,
			411,
			106,
			412,
			601,
			7
		}
	}
}

setmetatable(CfgMagicTowerFloorListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMagicTowerFloorListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		MapType = 0,
		BG = "",
		BGM = 0,
		MapData = {},
		CellID = {}
	}
}

for i, data in pairs(CfgMagicTowerFloorListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMagicTowerFloorListTable
