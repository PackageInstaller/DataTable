-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/config/ClimbingTowerEnum.lua

module("logic.extensions.climbingtower.config.ClimbingTowerEnum", package.seeall)

local ClimbingTowerEnum = {}

ClimbingTowerEnum.PageTyp = {
	DarkSide = 3,
	BrightSide = 2,
	Moon = 1
}
ClimbingTowerEnum.EntryTyp = {
	Finish = 2,
	Lock = 3,
	Normal = 1
}
ClimbingTowerEnum.PointerTyp = {
	Min = 2,
	Hour = 1
}
ClimbingTowerEnum.ClearStepBright = 4
ClimbingTowerEnum.ClearStepDark = 3

return ClimbingTowerEnum
