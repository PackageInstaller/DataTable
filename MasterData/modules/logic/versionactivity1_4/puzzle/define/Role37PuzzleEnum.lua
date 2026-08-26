-- chunkname: @modules/logic/versionactivity1_4/puzzle/define/Role37PuzzleEnum.lua

module("modules.logic.versionactivity1_4.puzzle.define.Role37PuzzleEnum", package.seeall)

local Role37PuzzleEnum = _M

Role37PuzzleEnum.ControlType = {
	Repleace = 4,
	Add = 1,
	Exchange = 3,
	Remove = 2,
	Move = 5
}
Role37PuzzleEnum.OperType = {
	Two = 2,
	Five = 5,
	Seven = 7,
	Three = 3,
	Four = 4,
	One = 1,
	Six = 6
}
Role37PuzzleEnum.AnimalRules = {
	[Role37PuzzleEnum.OperType.Three] = 1,
	[Role37PuzzleEnum.OperType.One] = 2,
	[Role37PuzzleEnum.OperType.Two] = 3
}
Role37PuzzleEnum.AnimalStr = {
	[Role37PuzzleEnum.AnimalRules[3]] = "v1a4_role37_puzzle_animal_wolf",
	[Role37PuzzleEnum.AnimalRules[1]] = "v1a4_role37_puzzle_animal_sheep",
	[Role37PuzzleEnum.AnimalRules[2]] = "v1a4_role37_puzzle_animal_dish"
}
Role37PuzzleEnum.PuzzleId = {
	Final = 801,
	WolfSheepDish = 601,
	SnailMove = 101,
	MonkeyBanana = 401,
	SortByRules7 = 501,
	SortByRules5 = 301
}
Role37PuzzleEnum.PuzzleType = {
	Sort = 2,
	Logic = 1
}

return Role37PuzzleEnum
