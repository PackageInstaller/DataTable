-- chunkname: @IQIGame\\Config\\CfgStateMachineTable.lua

local CfgStateMachineTable = {
	[1000] = {
		Id = 1000,
		ScriptName = "HeroInMaze",
		AssetName = "HeroInMaze"
	},
	[1001] = {
		Id = 1001,
		ScriptName = "FollowCameraInMaze",
		AssetName = "MazeFollowHeroCamera"
	},
	[1002] = {
		Id = 1002,
		ScriptName = "ElementInMaze",
		AssetName = "ElementInMaze"
	},
	[1003] = {
		Id = 1003,
		ScriptName = "BattleUnitPuppet",
		AssetName = "BattleUnitPuppet"
	},
	[1004] = {
		Id = 1004,
		ScriptName = "BattleUnitEnemy",
		AssetName = "BattleUnitEnemy"
	},
	[1005] = {
		Id = 1005,
		ScriptName = "HomelandRole",
		AssetName = "HomelandRole"
	},
	[1006] = {
		Id = 1006,
		ScriptName = "MoveElementInMaze",
		AssetName = "MoveElementInMaze"
	},
	[1007] = {
		Id = 1007,
		ScriptName = "TrapElementInMaze",
		AssetName = "TrapElementInMaze"
	},
	[1008] = {
		Id = 1008,
		ScriptName = "StoneElementInMaze",
		AssetName = "StoneElementInMaze"
	},
	[1009] = {
		Id = 1009,
		ScriptName = "BombElementInMaze",
		AssetName = "BombElementInMaze"
	},
	[1010] = {
		Id = 1010,
		ScriptName = "DreamlandHero",
		AssetName = "DreamlandHero"
	},
	[1011] = {
		Id = 1011,
		ScriptName = "DreamlandElement",
		AssetName = "DreamlandElement"
	},
	[1012] = {
		Id = 1012,
		ScriptName = "DualTeamExploreHero",
		AssetName = "DualTeamExploreHero"
	},
	[1013] = {
		Id = 1013,
		ScriptName = "DualTeamExploreElement",
		AssetName = "DualTeamExploreElement"
	},
	[1014] = {
		Id = 1014,
		ScriptName = "MagicTowerHero",
		AssetName = "MagicTowerHero"
	},
	[1015] = {
		Id = 1015,
		ScriptName = "MagicTowerElement",
		AssetName = "MagicTowerElement"
	}
}

setmetatable(CfgStateMachineTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgStateMachineTable]")
	end
})

local defaultMetaTable = {
	__index = {
		AssetName = "",
		ScriptName = ""
	}
}

for i, data in pairs(CfgStateMachineTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgStateMachineTable
