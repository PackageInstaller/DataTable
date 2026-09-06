-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/data/MusicGameEnum.lua

module("logic.extensions.musicgame.data.MusicGameEnum", package.seeall)

local MusicGameEnum = {}

MusicGameEnum.GameResult_Success = "GameResult_Success"
MusicGameEnum.GameResult_Fail = "GameResult_Fail"
MusicGameEnum.GameEndRes_ForceExit = "GameEndRes_ForceExit"
MusicGameEnum.GameEndRes_Exit = "GameEndRes_Exit"
MusicGameEnum.GameEndRes_Finish = "GameEndRes_Finish"
MusicGameEnum.GameStatusOp_Close = "GameStatusOp_Close"
MusicGameEnum.GameStatusOp_Continue = "GameStatusOp_Continue"
MusicGameEnum.State_Preparing = "State_Preparing"
MusicGameEnum.State_Runing = "State_Runing"
MusicGameEnum.State_Stoping = "State_Stoping"
MusicGameEnum.State_Ended = "State_Ended"
MusicGameEnum.SymbolState_Standing = "SymbolState_Standing"
MusicGameEnum.SymbolState_Running = "SymbolState_Running"
MusicGameEnum.SymbolState_Ending = "SymbolState_Ending"
MusicGameEnum.SymbolState_Ended = "SymbolState_Ended"
MusicGameEnum.LineFields = {
	"lineOne",
	"lineTwo",
	"lineThree",
	"lineFour",
	"lineFive",
	"lineSix",
	"lineSeven",
	"lineEight"
}
MusicGameEnum.DischargeType_One = 1
MusicGameEnum.DischargeType_Two = 2
MusicGameEnum.DischargeTypeFields = {
	"oneCount",
	"twoCount"
}

return MusicGameEnum
