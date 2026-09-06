-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/data/KingArenaEnum.lua

module("logic.extensions.kingarena.data.KingArenaEnum", package.seeall)

local KingArenaEnum = {}

KingArenaEnum.RankType_Fight_One = 1
KingArenaEnum.RankType_Fight_Two = 2
KingArenaEnum.RankType_Pet_One = 1
KingArenaEnum.RankType_Pet_Two = 2
KingArenaEnum.RankSide_Attack = 1
KingArenaEnum.RankSide_Defense = 2
KingArenaEnum.RankSideList = {
	KingArenaEnum.RankSide_Attack,
	KingArenaEnum.RankSide_Defense
}
KingArenaEnum.RankSideNames = {}
KingArenaEnum.RankSideNames[KingArenaEnum.RankSide_Attack] = "进攻方"
KingArenaEnum.RankSideNames[KingArenaEnum.RankSide_Defense] = "防守方"
KingArenaEnum.StepChangeState_Season = 1
KingArenaEnum.StepChangeState_Period = 2

return KingArenaEnum
