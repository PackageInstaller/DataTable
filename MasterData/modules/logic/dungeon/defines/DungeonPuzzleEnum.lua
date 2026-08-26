-- chunkname: @modules/logic/dungeon/defines/DungeonPuzzleEnum.lua

module("modules.logic.dungeon.defines.DungeonPuzzleEnum", package.seeall)

local DungeonPuzzleEnum = _M

DungeonPuzzleEnum.hintCount = 3
DungeonPuzzleEnum.pipeEntryClearCount = 2
DungeonPuzzleEnum.pipeEntryClearDecimal = 10
DungeonPuzzleEnum.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
DungeonPuzzleEnum.backgroundRes = {
	[0] = {
		"bg_jiemi_weijietuong",
		0,
		0,
		0
	},
	[28] = {
		"bg_jiemi_zhixian",
		0,
		0,
		0
	},
	[46] = {
		"bg_jiemi_zhixian",
		90,
		0,
		0
	},
	[48] = {
		"bg_jiemi_guaijiao",
		90,
		45.2,
		36
	},
	[68] = {
		"bg_jiemi_guaijiao",
		0,
		45.2,
		36
	},
	[26] = {
		"bg_jiemi_guaijiao",
		270,
		45.2,
		36
	},
	[24] = {
		"bg_jiemi_guaijiao",
		180,
		45.2,
		36
	},
	[468] = {
		"bg_jiemi_sancha",
		0,
		0,
		36
	},
	[268] = {
		"bg_jiemi_sancha",
		270,
		0,
		36
	},
	[246] = {
		"bg_jiemi_sancha",
		180,
		0,
		36
	},
	[248] = {
		"bg_jiemi_sancha",
		90,
		0,
		36
	}
}
DungeonPuzzleEnum.connectRes = {
	[0] = {
		"bg_jiemi_jietuong",
		0,
		0,
		0
	},
	[28] = {
		"bg_jiemi_lianjie_1",
		0,
		0,
		0
	},
	[46] = {
		"bg_jiemi_lianjie_1",
		90,
		0,
		0
	},
	[48] = {
		"bg_jiemi_lianjie_2",
		90,
		47.1,
		43
	},
	[68] = {
		"bg_jiemi_lianjie_2",
		0,
		47.1,
		43
	},
	[26] = {
		"bg_jiemi_lianjie_2",
		270,
		47.1,
		43
	},
	[24] = {
		"bg_jiemi_lianjie_2",
		180,
		47.1,
		43
	},
	[468] = {
		"bg_jiemi_lianjie_3",
		90,
		46.4,
		-6.4
	},
	[268] = {
		"bg_jiemi_lianjie_3",
		0,
		46.4,
		-6.4
	},
	[246] = {
		"bg_jiemi_lianjie_3",
		270,
		46.4,
		-6.4
	},
	[248] = {
		"bg_jiemi_lianjie_3",
		180,
		46.4,
		-6.4
	}
}
DungeonPuzzleEnum.mazeDrawWidth = 4
DungeonPuzzleEnum.mazeDrawHeight = 3
DungeonPuzzleEnum.mazeUIGridWidth = 257.3
DungeonPuzzleEnum.mazeUIGridHeight = 167.5
DungeonPuzzleEnum.mazeUILineWidth = 90
DungeonPuzzleEnum.mazeUILineHorizonUIWidth = 261.2
DungeonPuzzleEnum.mazeUILineVerticalUIWidth = 170.5
DungeonPuzzleEnum.mazeMonsterHeight = 45
DungeonPuzzleEnum.mazeMonsterTouchOffsetX = 0
DungeonPuzzleEnum.MazeObjType = {
	CheckPointPassed = 14,
	End = 2,
	CheckPoint = 4,
	Start = 1,
	Block = 3
}
DungeonPuzzleEnum.MazeObjResType = {
	[DungeonPuzzleEnum.MazeObjType.Start] = {
		"ui_maze_start",
		-13.1,
		13.1
	},
	[DungeonPuzzleEnum.MazeObjType.End] = {
		"ui_maze_end",
		-21.7,
		7.2
	},
	[DungeonPuzzleEnum.MazeObjType.Block] = {
		"bg_zhangai_1",
		3.4,
		0,
		"bg_zhangai_1_dis"
	},
	[DungeonPuzzleEnum.MazeObjType.CheckPoint] = {
		"bg_didian_1_dis",
		1.7,
		22.1
	},
	[DungeonPuzzleEnum.MazeObjType.CheckPointPassed] = {
		"bg_didian_1",
		1.7,
		22.1
	}
}
DungeonPuzzleEnum.mazeCheckPointResMap = {
	[0] = {
		"bg_didian_1_dis",
		1,
		30
	},
	{
		"bg_didian_2_dis",
		4.6,
		34.3
	},
	{
		"bg_didian_3_dis",
		1.3,
		32.3
	},
	{
		"bg_didian_4_dis",
		16.7,
		32.1
	},
	{
		"bg_didian_5_dis",
		-6.5,
		29.1
	}
}
DungeonPuzzleEnum.mazeCheckPointPassedResMap = {
	[0] = {
		"bg_didian_1",
		1,
		30
	},
	{
		"bg_didian_2",
		4.6,
		34.3
	},
	{
		"bg_didian_3",
		1.3,
		32.3
	},
	{
		"bg_didian_4",
		16.7,
		32.1
	},
	{
		"bg_didian_5",
		-6.5,
		29.1
	}
}
DungeonPuzzleEnum.mazeBlockResMap = {
	[0] = {
		"bg_zhangai_1",
		-2.8,
		-7.3,
		"bg_zhangai_1_dis"
	},
	{
		"bg_zhangai_2",
		32.6,
		0,
		"bg_zhangai_2_dis"
	},
	{
		"bg_zhangai_3",
		10,
		-11.3,
		"bg_zhangai_3_dis"
	},
	{
		"bg_zhangai_4",
		2.6,
		2,
		"bg_zhangai_4_dis"
	}
}
DungeonPuzzleEnum.NormalLineResPath = {
	"bg_huaxian_1",
	0,
	0,
	"bg_huaxian_1_dis"
}
DungeonPuzzleEnum.SpecLineResMap = {}
DungeonPuzzleEnum.MazeAlertBlockOffsetX, DungeonPuzzleEnum.MazeAlertBlockOffsetY = 90.8, 48.5
DungeonPuzzleEnum.MazeAlertCrossOffsetX, DungeonPuzzleEnum.MazeAlertCrossOffsetY = 25.3, 33.1
DungeonPuzzleEnum.MazePawnPath = {
	"ui_maze_pawn",
	3.1,
	65.5
}
DungeonPuzzleEnum.MazePawnWidth = 282
DungeonPuzzleEnum.MazePawnHeight = 216
DungeonPuzzleEnum.MazeAlertResPath = "ui_maze_alert"
DungeonPuzzleEnum.AnimEvent_OnJump = "OnJump"

return DungeonPuzzleEnum
