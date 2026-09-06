-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/data/MagicSchoolPvPEnum.lua

module("logic.extensions.magicschoolpvp.data.MagicSchoolPvPEnum", package.seeall)

local MagicSchoolPvPEnum = {}

MagicSchoolPvPEnum.CampId_Black = 1
MagicSchoolPvPEnum.CampId_White = 2
MagicSchoolPvPEnum.CampIdList = {
	MagicSchoolPvPEnum.CampId_Black,
	MagicSchoolPvPEnum.CampId_White
}
MagicSchoolPvPEnum.PeriodType_Match = 1
MagicSchoolPvPEnum.PeriodType_Ready = 2
MagicSchoolPvPEnum.PeriodType_Boss = 3
MagicSchoolPvPEnum.PeriodType_End = 4
MagicSchoolPvPEnum.RoundType_Battle = "battle"
MagicSchoolPvPEnum.RoundType_Buff = "buff"
MagicSchoolPvPEnum.MaxSwitchPosTimes = 1

return MagicSchoolPvPEnum
