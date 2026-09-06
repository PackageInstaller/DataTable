-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameEnum.lua

module("logic.extensions.fishinggame.model.FishingGameEnum", package.seeall)

local FishingGameEnum = {}

FishingGameEnum.UnitType = {
	Fish = 1,
	ElectricEel = 7,
	AttackFish = 2,
	LimitTreasureBox = 5,
	PowerGrid = 6,
	Player = 8,
	Grass = 3,
	TreasureBox = 4
}
FishingGameEnum.FishType = {
	Fish = 1,
	ElectricEel = 7,
	AttackFish = 2,
	LimitTreasureBox = 5,
	PowerGrid = 6,
	Grass = 3,
	TreasureBox = 4
}
FishingGameEnum.UnitState = {
	AttackHit = 6,
	Attack = 4,
	Idle = 1,
	Hooked = 2,
	Throwing = 3,
	Dead = 5
}
FishingGameEnum.FishState = FishingGameEnum.UnitState
FishingGameEnum.FishDirect = {
	Left = -1,
	Right = 1
}
FishingGameEnum.BoatDirect = {
	Right = 1,
	Left = -1,
	None = 0
}
FishingGameEnum.RodDirect = {
	Right = 1,
	Left = -1,
	None = 0
}
FishingGameEnum.RodAddDirect = {
	Down = 1,
	Up = -1,
	None = 0
}

return FishingGameEnum
