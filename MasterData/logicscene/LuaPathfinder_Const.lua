-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/pathfinder/lua/LuaPathfinder_Const.lua

module("logicscene.scene.component.pathfinder.lua.LuaPathfinder_Const", package.seeall)

local LuaPathfinder_Const = {}

LuaPathfinder_Const.CostFlag_Dir_8 = 1
LuaPathfinder_Const.CostFlag_Dir_8to6 = 2
LuaPathfinder_Const.CostFlag_Dir_4 = 3
LuaPathfinder_Const.HeuristicFlag_Manhattan = 1
LuaPathfinder_Const.HeuristicFlag_Diagonal = 2
LuaPathfinder_Const.HeuristicFlag_Euclidean = 3
LuaPathfinder_Const.BlockType_None = nil
LuaPathfinder_Const.BlockType_Trap = 1
LuaPathfinder_Const.BlockType_Wall = 2
LuaPathfinder_Const.Sqrt2 = 1.41421
LuaPathfinder_Const.Cost = {
	[LuaPathfinder_Const.CostFlag_Dir_8] = {
		1.41421,
		1,
		1.41421,
		1,
		0,
		1,
		1.41421,
		1,
		1.41421
	},
	[LuaPathfinder_Const.CostFlag_Dir_8to6] = {
		[0] = {
			1,
			1,
			1,
			1,
			0,
			1,
			-1,
			1,
			-1
		},
		{
			-1,
			1,
			-1,
			1,
			0,
			1,
			1,
			1,
			1
		}
	},
	[LuaPathfinder_Const.CostFlag_Dir_4] = {
		-1,
		1,
		-1,
		1,
		0,
		1,
		-1,
		1,
		-1
	}
}
LuaPathfinder_Const.Directions = {
	{
		-1,
		1
	},
	{
		0,
		1
	},
	{
		1,
		1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	}
}
LuaPathfinder_Const.Directions2Index = {
	[-1] = {
		[0] = 4,
		1,
		[-1] = 7
	},
	[0] = {
		[0] = 5,
		2,
		[-1] = 8
	},
	{
		[0] = 6,
		3,
		[-1] = 9
	}
}
LuaPathfinder_Const.Directions_Hex_Cube_6 = {
	{
		1,
		0,
		-1
	},
	{
		1,
		-1,
		0
	},
	{
		0,
		-1,
		1
	},
	{
		-1,
		0,
		1
	},
	{
		-1,
		1,
		0
	},
	{
		0,
		1,
		-1
	}
}

return LuaPathfinder_Const
