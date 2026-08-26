-- chunkname: @modules/logic/seasonver/act166/define/Season166Enum.lua

module("modules.logic.seasonver.act166.define.Season166Enum", package.seeall)

local Season166Enum = _M

Season166Enum.ActType = 166
Season166Enum.EmptyUid = "0"
Season166Enum.MaxHeroCount = 8
Season166Enum.ActId = 12618
Season166Enum.SpOpenTimeConstId = 2
Season166Enum.TrainSpType = 1
Season166Enum.InfoCostId = 1
Season166Enum.TeachStoryConstId = 108
Season166Enum.UnlockState = 1
Season166Enum.LockState = 0
Season166Enum.CloseSeasonEnterTime = 3
Season166Enum.EnterViewBgUrl = 4
Season166Enum.MainSceneUrl = 5
Season166Enum.JumpId = {
	TrainView = 2,
	BaseSpotEpisode = 4,
	MainView = 1,
	TrainEpisode = 5,
	TeachView = 3
}
Season166Enum.InforMainLocalSaveKey = "Season166InformationMainView"
Season166Enum.TalentLockSaveKey = "Season166Talent"
Season166Enum.ReportUnlockAnimLocalSaveKey = "ReportUnlockAnimLocalSaveKey"
Season166Enum.ReportFinishAnimLocalSaveKey = "ReportFinishAnimLocalSaveKey"
Season166Enum.TeachLockSaveKey = "Season166Teach"
Season166Enum.TalentLvlLocalSaveKey = "Season166TalentLvl"
Season166Enum.MainTrainLockSaveKey = "Season166MainTrain"
Season166Enum.ToastPath = "ui/viewres/seasonver/act166/season166toastitem.prefab"
Season166Enum.EnterSpotKey = "EnterSpotKey"
Season166Enum.MainTrainFinishSaveKey = "Season166MainTrainFinish"
Season166Enum.ToastType = {
	Info = 2,
	Talent = 1
}
Season166Enum.WordInterval = 7
Season166Enum.WordTxtPosYOffset = 5
Season166Enum.WordTxtPosXOffset = 2
Season166Enum.WordTxtInterval = 0.2
Season166Enum.WordTxtOpen = 0.7
Season166Enum.WordTxtIdle = 1.1
Season166Enum.WordTxtClose = 0.5
Season166Enum.WordLine2Delay = 1
Season166Enum.WordBaseSpotType = 1
Season166Enum.WordTrainType = 2

return Season166Enum
