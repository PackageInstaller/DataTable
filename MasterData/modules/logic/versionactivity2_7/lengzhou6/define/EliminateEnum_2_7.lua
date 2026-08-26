-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/define/EliminateEnum_2_7.lua

module("modules.logic.versionactivity2_7.lengzhou6.define.EliminateEnum_2_7", package.seeall)

local EliminateEnum_2_7 = class("EliminateEnum_2_7", EliminateEnum)

EliminateEnum_2_7.MaxBuffCount = 50
EliminateEnum_2_7.ChessType = {
	beast = "beast",
	cliff = "cliff",
	stone = "stone",
	tree = "tree",
	star = "star"
}
EliminateEnum_2_7.ChessIndexToType = {
	nil,
	nil,
	nil,
	nil,
	nil,
	"beast",
	"tree",
	"cliff",
	[9] = "star",
	[10] = "stone"
}
EliminateEnum_2_7.ChessTypeToIndex = {
	beast = 6,
	cliff = 8,
	stone = 10,
	tree = 7,
	star = 9
}
EliminateEnum_2_7.eliminateType = {
	five = "five",
	three = "three",
	base = "base",
	four = "four",
	cross = "cross"
}
EliminateEnum_2_7.AllChessType = {
	"beast",
	"tree",
	"cliff",
	"star"
}
EliminateEnum_2_7.AllChessID = {
	6,
	7,
	8,
	9
}
EliminateEnum_2_7.ChessWidth = 120
EliminateEnum_2_7.ChessHeight = 122
EliminateEnum_2_7.ChessIntervalX = 2
EliminateEnum_2_7.ChessIntervalY = 2
EliminateEnum_2_7.MaxRow = 6
EliminateEnum_2_7.MaxCol = 6
EliminateEnum_2_7.AssessShowTime = LengZhou6Config.instance:getEliminateBattleCost(26) / 1000
EliminateEnum_2_7.UpdateDamageStepTime = 1
EliminateEnum_2_7.DieStepTime = 0.3
EliminateEnum_2_7.AssessLevel = {
	3,
	5,
	7,
	10
}
EliminateEnum_2_7.AssessLevelToImageName = {
	"v2a7_hissabeth_game_paneltips3",
	"v2a7_hissabeth_game_paneltips4",
	"v2a7_hissabeth_game_paneltips5",
	"v2a7_hissabeth_game_paneltips6"
}
EliminateEnum_2_7.SpecialChessImage = {
	frost = LengZhou6Config.instance:getEliminateBattleCostStr(23),
	pollution = LengZhou6Config.instance:getEliminateBattleCostStr(22),
	beast = LengZhou6Config.instance:getEliminateBattleCostStr(18),
	tree = LengZhou6Config.instance:getEliminateBattleCostStr(19),
	cliff = LengZhou6Config.instance:getEliminateBattleCostStr(21),
	star = LengZhou6Config.instance:getEliminateBattleCostStr(20)
}
EliminateEnum_2_7.ChessEffect = {
	frost = "frost",
	pollution = "pollution"
}
EliminateEnum_2_7.SpecialChessAni = {
	frost = "freeze",
	pollution = "glitch"
}
EliminateEnum_2_7.InitDropTime = 0.1

return EliminateEnum_2_7
