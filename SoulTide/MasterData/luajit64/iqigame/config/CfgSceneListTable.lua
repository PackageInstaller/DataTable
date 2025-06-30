-- chunkname: @IQIGame\\Config\\CfgSceneListTable.lua

local CfgSceneListTable = {
	[0] = {
		Id = 0,
		SceneFile = "Undefined"
	},
	{
		Id = 1,
		BGM = 3,
		SceneFile = "Login",
		Type = 2
	},
	{
		Id = 2,
		LoadingUI = "LoadingNormalUI",
		SceneFile = "MainCity",
		Type = 1
	},
	{
		Type = 2,
		Id = 3,
		SceneFile = "Maze",
		LoadingUI = "LoadingMazeAreaUI",
		StateGroup = {
			1000,
			1002,
			1006,
			1007,
			1008,
			1009
		}
	},
	{
		Type = 2,
		Id = 4,
		SceneFile = "Battle",
		LoadingUI = "BattleLoadingUI",
		StateGroup = {
			1003,
			1004
		}
	},
	{
		Type = 1,
		Id = 5,
		SceneFile = "Home",
		LoadingUI = "LoadingHomeUI",
		StateGroup = {
			1005
		}
	},
	{
		Id = 6,
		LoadingUI = "LoadingTownUI",
		SceneFile = "TownArea",
		Type = 1
	},
	{
		Id = 7,
		LoadingUI = "LoadingGirlUI",
		SceneFile = "Girl",
		Type = 1
	},
	{
		Type = 1,
		Id = 8,
		SceneFile = "Dreamland",
		LoadingUI = "LoadingNormalUI",
		StateGroup = {
			1010,
			1011
		}
	},
	{
		Id = 9,
		LoadingUI = "LoadingNormalUI",
		SceneFile = "Panda",
		Type = 1
	},
	{
		Type = 1,
		Id = 10,
		SceneFile = "DualTeamExplore",
		LoadingUI = "LoadingNormalUI",
		StateGroup = {
			1012,
			1013
		}
	},
	{
		Id = 11,
		LoadingUI = "LoadingNormalUI",
		SceneFile = "Memory",
		Type = 1
	},
	{
		Id = 12,
		LoadingUI = "LoadingNormalUI",
		SceneFile = "CommonActivity",
		Type = 1
	}
}

setmetatable(CfgSceneListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSceneListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		SceneFile = "",
		LoadingUI = "",
		Type = 0,
		BGM = 0,
		StateGroup = {}
	}
}

for i, data in pairs(CfgSceneListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSceneListTable
