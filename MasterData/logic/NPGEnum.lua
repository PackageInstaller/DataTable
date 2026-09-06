-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/data/NPGEnum.lua

module("logic.extensions.numberpuzzlegame.view.data.NPGEnum", package.seeall)

local NPGEnum = {}

NPGEnum.GameMode_Nor = 1
NPGEnum.GameMode_Ext = 2
NPGEnum.GameMode_Sup = 3
NPGEnum.ToUp = Vector2.New(0, 1)
NPGEnum.ToDown = Vector2.New(0, -1)
NPGEnum.ToLeft = Vector2.New(-1, 0)
NPGEnum.ToRight = Vector2.New(1, 0)
NPGEnum.TowardList = {
	NPGEnum.ToUp,
	NPGEnum.ToDown,
	NPGEnum.ToLeft,
	NPGEnum.ToRight
}
NPGEnum.State_Runing = "State_Runing"
NPGEnum.State_Stoping = "State_Stoping"
NPGEnum.State_Ended = "State_Ended"
NPGEnum.Motion_None = "Motion_None"
NPGEnum.Motion_Move = "Motion_Move"
NPGEnum.Motion_Merge = "Motion_Merge"
NPGEnum.Motion_Create = "Motion_Create"
NPGEnum.Motion_Destroy = "Motion_Destroy"
NPGEnum.Motion_Queue = "Motion_Queue"
NPGEnum.Motion_UniversalCard = "Motion_UniversalCard"
NPGEnum.Motion_Knock = "Motion_Knock"
NPGEnum.Prop_Queue = 1
NPGEnum.Prop_UniversalCard = 2
NPGEnum.Prop_Knock = 3
NPGEnum.PropList = {
	NPGEnum.Prop_Queue,
	NPGEnum.Prop_UniversalCard,
	NPGEnum.Prop_Knock
}
NPGEnum.ResultCode_Success = "ResultCode_Success"
NPGEnum.ResultCode_Error = "ResultCode_Error"
NPGEnum.ResultCode_GameRuning = "ResultCode_GameRuning"
NPGEnum.ResultCode_GameOverOfSuccess = "ResultCode_GameOverOfSuccess"
NPGEnum.ResultCode_GameOverOfFail = "ResultCode_GameOverOfFail"
NPGEnum.ResultCode_GameOverOfDropOut = "ResultCode_GameOverOfDropOut"
NPGEnum.ResultCode_GameOverFailAndReset = "ResultCode_GameOverFailAndReset"
NPGEnum.SequenceKey_Motion = 1
NPGEnum.ResultCode_EmptyGridId = 0
NPGEnum.ResultCode_UniversalGridId = -1

return NPGEnum
