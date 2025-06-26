-- chunkname: @IQIGame\\Config\\CfgLabyrinthSceneListTable.lua

local CfgLabyrinthSceneListTable = {
	[40010001] = {
		Id = 40010001,
		SceneID = "/Maze/Scene/MazeScene_01.prefab"
	},
	[40010002] = {
		Id = 40010002,
		SceneID = "/Maze/Scene/MazeScene_02.prefab"
	},
	[40010003] = {
		Id = 40010003,
		SceneID = "/Maze/Scene/MazeScene_03.prefab"
	},
	[40010004] = {
		Id = 40010004,
		SceneID = "/Maze/Scene/MazeScene_04.prefab"
	},
	[40010005] = {
		Id = 40010005,
		SceneID = "/Maze/Scene/MazeScene_05.prefab"
	},
	[40010006] = {
		Id = 40010006,
		SceneID = "/Maze/Scene/MazeScene_06.prefab"
	},
	[40010007] = {
		Id = 40010007,
		SceneID = "/Maze/Scene/MazeScene_07.prefab"
	},
	[40010008] = {
		Id = 40010008,
		SceneID = "/Maze/Scene/MazeScene_08.prefab"
	},
	[40010009] = {
		Id = 40010009,
		SceneID = "/Maze/Scene/MazeScene_09.prefab"
	},
	[40010010] = {
		Id = 40010010,
		SceneID = "/Maze/Scene/MazeScene_10.prefab"
	},
	[40010011] = {
		Id = 40010011,
		SceneID = "/Maze/Scene/MazeScene_11.prefab"
	},
	[40010012] = {
		Id = 40010012,
		SceneID = "/Maze/Scene/MazeScene_12.prefab"
	},
	[40010013] = {
		Id = 40010013,
		SceneID = "/Maze/Scene/MazeScene_13.prefab"
	},
	[40010014] = {
		Id = 40010014,
		SceneID = "/Maze/Scene/MazeScene_14.prefab"
	},
	[40010015] = {
		Id = 40010015,
		SceneID = "/Maze/Scene/MazeScene_15.prefab"
	},
	[40010016] = {
		Id = 40010016,
		SceneID = "/Maze/Scene/MazeScene_16.prefab"
	},
	[40010017] = {
		Id = 40010017,
		SceneID = "/Maze/Scene/MazeScene_17.prefab"
	},
	[40010018] = {
		Id = 40010018,
		SceneID = "/Maze/Scene/MazeScene_18.prefab"
	},
	[40010019] = {
		Id = 40010019,
		SceneID = "/Maze/Scene/MazeScene_19.prefab"
	}
}

setmetatable(CfgLabyrinthSceneListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthSceneListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		SceneID = ""
	}
}

for i, data in pairs(CfgLabyrinthSceneListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthSceneListTable
