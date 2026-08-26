-- chunkname: @modules/logic/versionactivity1_4/act130/define/Activity130Event.lua

module("modules.logic.versionactivity1_4.act130.define.Activity130Event", package.seeall)

local Activity130Event = _M

Activity130Event.OneClickClaimReward = 1
Activity130Event.OnGetInfoSuccess = 1001
Activity130Event.OnStoryFinishedSuccess = 1002
Activity130Event.OnGeneralGameSuccess = 1004
Activity130Event.OnDialogMarkSuccess = 1005
Activity130Event.OnDialogHistorySuccess = 1006
Activity130Event.OnElementUpdate = 1007
Activity130Event.OnRestartEpisodeSuccess = 1008
Activity130Event.OnClickElement = 40002
Activity130Event.RefreshTaskTip = 40003
Activity130Event.UnlockDecrypt = 40004
Activity130Event.CheckDecrypt = 40005
Activity130Event.AutoStartElement = 40006
Activity130Event.UnlockCollect = 40007
Activity130Event.SetScenePos = 40008
Activity130Event.EpisodeClick = 40009
Activity130Event.ShowTipDialog = 40010
Activity130Event.ShowLevelScene = 50001
Activity130Event.BackToLevelView = 50002
Activity130Event.NewEpisodeUnlock = 50003
Activity130Event.playNewFinishEpisode = 50004
Activity130Event.playNewUnlockEpisode = 50005
Activity130Event.PlayChessAutoToNewEpisode = 50006
Activity130Event.StartEnterGameView = 50007
Activity130Event.PlayLeaveLevelView = 50008
Activity130Event.EnterEpisode = 50009
Activity130Event.OnAddElement = 60001
Activity130Event.GuideClickElement = 60002
Activity130Event.OnCollectEffectFinished = 60003
Activity130Event.OnUnlockDecryptBtn = 60004

return Activity130Event
