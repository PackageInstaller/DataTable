-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/data/UltimateWarEnum.lua

module("logic.extensions.ultimatewar.data.UltimateWarEnum", package.seeall)

local UltimateWarEnum = {}

UltimateWarEnum.StepId_One = 1
UltimateWarEnum.StepId_Two = 2
UltimateWarEnum.StepId_Three = 3
UltimateWarEnum.StepUnlock_Levels = {
	[UltimateWarEnum.StepId_One] = 0,
	[UltimateWarEnum.StepId_Two] = 2,
	[UltimateWarEnum.StepId_Three] = 4
}
UltimateWarEnum.RankType_TowerStage = 270
UltimateWarEnum.RankType_TowerBoss = 271
UltimateWarEnum.RankType_FinalBoss = 272
UltimateWarEnum.Story_Plot_1 = 1
UltimateWarEnum.Story_Plot_2 = 2
UltimateWarEnum.Story_Plot_3 = 3
UltimateWarEnum.Story_Plot_4 = 4
UltimateWarEnum.Story_Plot_5 = 5
UltimateWarEnum.GameType_Axmm = 1

return UltimateWarEnum
