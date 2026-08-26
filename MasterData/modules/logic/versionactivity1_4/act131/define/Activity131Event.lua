-- chunkname: @modules/logic/versionactivity1_4/act131/define/Activity131Event.lua

module("modules.logic.versionactivity1_4.act131.define.Activity131Event", package.seeall)

local Activity131Event = _M

Activity131Event.OneClickClaimReward = 1
Activity131Event.OnGetInfoSuccess = 1001
Activity131Event.OnStoryFinishedSuccess = 1002
Activity131Event.OnGeneralGameSuccess = 1004
Activity131Event.OnDialogMarkSuccess = 1005
Activity131Event.OnDialogHistorySuccess = 1006
Activity131Event.OnElementUpdate = 1007
Activity131Event.OnRestartEpisodeSuccess = 1008
Activity131Event.OnBattleBeforeSucess = 1009
Activity131Event.OnClickElement = 40002
Activity131Event.RefreshTaskTip = 40003
Activity131Event.AutoStartElement = 40006
Activity131Event.UnlockCollect = 40007
Activity131Event.TriggerLogElement = 40008
Activity131Event.TriggerBattleElement = 40009
Activity131Event.EpisodeClick = 400010
Activity131Event.ShowLevelScene = 50001
Activity131Event.OnSetEpisodeListVisible = 50002
Activity131Event.playNewFinishEpisode = 50003
Activity131Event.playNewUnlockEpisode = 50004
Activity131Event.BackToLevelView = 50005
Activity131Event.PlayChessAutoToNewEpisode = 50006
Activity131Event.StartEnterGameView = 50007
Activity131Event.PlayLeaveLevelView = 50008
Activity131Event.EnterEpisode = 50009
Activity131Event.SelectCategory = 60001
Activity131Event.LogSelected = 60002
Activity131Event.LogAudioFinished = 60003
Activity131Event.ShowFinish = 70001
Activity131Event.SetScenePos = 70002
Activity131Event.FirstFinish = 70003

return Activity131Event
