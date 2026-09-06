-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownEnum.lua

module("logic.extensions.showdown.data.ShowDownEnum", package.seeall)

local ShowDownEnum = {}

ShowDownEnum.RacePeriod_Error = "RacePeriod_Error"
ShowDownEnum.RacePeriod_Qualify = "RacePeriod_Qualify"
ShowDownEnum.RacePeriod_Eliminate = "RacePeriod_Eliminate"
ShowDownEnum.RacePeriod_Final = "RacePeriod_Final"
ShowDownEnum.RacePeriod_Func = "RacePeriod_Func"
ShowDownEnum.QualType_Normal = 1
ShowDownEnum.QualType_Fun = 2
ShowDownEnum.Round_Qualify = 1
ShowDownEnum.Round_Eliminate_Group = 2
ShowDownEnum.Round_Eliminate_512To64 = 3
ShowDownEnum.Round_Eliminate_64To8 = 4
ShowDownEnum.Round_Final_01 = 5
ShowDownEnum.Round_Final_02 = 6
ShowDownEnum.Round_Final_03 = 7
ShowDownEnum.Round_Final_04 = 8
ShowDownEnum.Round_Final_05 = 9
ShowDownEnum.Round_Final_06 = 10
ShowDownEnum.Round_Final_07 = 11
ShowDownEnum.Round_Final_Result = 12
ShowDownEnum.Round_Func = 999999
ShowDownEnum.FormIndexFunc = 999999
ShowDownEnum.RoundInRace = {}
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Qualify] = ShowDownEnum.RacePeriod_Qualify
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Eliminate_Group] = ShowDownEnum.RacePeriod_Eliminate
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Eliminate_512To64] = ShowDownEnum.RacePeriod_Eliminate
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Eliminate_64To8] = ShowDownEnum.RacePeriod_Eliminate
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_01] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_02] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_03] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_04] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_05] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_06] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_07] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Final_Result] = ShowDownEnum.RacePeriod_Final
ShowDownEnum.RoundInRace[ShowDownEnum.Round_Func] = ShowDownEnum.RacePeriod_Func
ShowDownEnum.FinalRoundIdList = {
	ShowDownEnum.Round_Final_01,
	ShowDownEnum.Round_Final_02,
	ShowDownEnum.Round_Final_03,
	ShowDownEnum.Round_Final_04,
	ShowDownEnum.Round_Final_05,
	ShowDownEnum.Round_Final_06,
	ShowDownEnum.Round_Final_07
}
ShowDownEnum.FormPeriod_None = "none"
ShowDownEnum.FormPeriod_Daily = "daily"
ShowDownEnum.FormPeriod_Round = "round"
ShowDownEnum.BattleRecordResult_Fail = -1
ShowDownEnum.BattleRecordResult_Draw = 0
ShowDownEnum.BattleRecordResult_Win = 1
ShowDownEnum.PkEffPaths = {
	[1] = "20240430/leitaisai/fx_ui_pkdonghua",
	[2] = "20240430/leitaisai/fx_ui_leitaisai_zuozhan2"
}
ShowDownEnum.FmtAdjustState_Adjust = "FmtAdjustState_Adjust"
ShowDownEnum.FmtAdjustState_Viewer = "FmtAdjustState_Viewer"

return ShowDownEnum
