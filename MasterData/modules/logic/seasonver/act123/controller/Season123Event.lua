-- chunkname: @modules/logic/seasonver/act123/controller/Season123Event.lua

module("modules.logic.seasonver.act123.controller.Season123Event", package.seeall)

local Season123Event = _M

Season123Event.GetActInfo = 1001
Season123Event.GetActInfoBattleFinish = 1002
Season123Event.OnEquipItemChange = 1003
Season123Event.OnPlayerPrefNewUpdate = 1004
Season123Event.StageInfoChanged = 1005
Season123Event.SetRetailScene = 1006
Season123Event.SwitchRetailPrefab = 1007
Season123Event.TaskUpdated = 1008
Season123Event.OtherViewAutoOpened = 1009
Season123Event.StageFinishWithoutStory = 1010
Season123Event.EntrySceneLoaded = 1101
Season123Event.EntrySceneFocusPos = 1102
Season123Event.ReleaseFocusPos = 1103
Season123Event.EntryStageChanged = 1104
Season123Event.OnSetStage = 1105
Season123Event.RetailObjLoaded = 1106
Season123Event.LocateToStage = 1201
Season123Event.EnterStageSuccess = 2001
Season123Event.PickViewRefresh = 2002
Season123Event.PickEntryRefresh = 2003
Season123Event.EpisodeViewRefresh = 2004
Season123Event.ResetStageFinished = 2005
Season123Event.OpenEpisodeRewardView = 2006
Season123Event.ResetCloseEpisodeList = 2007
Season123Event.StartEnterBattle = 3001
Season123Event.HeroGroupIndexChanged = 3002
Season123Event.RecordRspMainCardRefresh = 3003
Season123Event.StartFightFailed = 3004
Season123Event.OnTaskRewardGetFinish = 4001
Season123Event.OnEquipBookItemChangeSelect = 4002
Season123Event.OnRefleshEquipBookView = 4003
Season123Event.OnResetBatchDecomposeView = 4004
Season123Event.OnRefleshDecomposeItemUI = 4005
Season123Event.OnDecomposeItemSelect = 4006
Season123Event.OnItemChange = 4007
Season123Event.OnCardPackageOpen = 4008
Season123Event.OnDecomposeEffectPlay = 4009
Season123Event.OnBatchDecomposeEffectPlay = 4010
Season123Event.CloseBatchDecomposeEffect = 4011
Season123Event.EnemyDetailSwitchTab = 5001
Season123Event.EnemyDetailSelectEnemy = 5002
Season123Event.DetailSwitchLayer = 6001
Season123Event.RefreshDetailView = 6002
Season123Event.OnCoverItemClick = 7001
Season123Event.EnterEpiosdeList = 8001
Season123Event.EnterRetailView = 8002
Season123Event.SetCareer = 9001
Season123Event.RefreshSelectAssistHero = 9002
Season123Event.BeforeRefreshAssistList = 9003
Season123Event.clickTaskMapItem = 10001
Season123Event.RefreshResetView = 11001
Season123Event.OnResetSucc = 11002
Season123Event.GotCardView = 99001
Season123Event.GuideEntryOtherViewPop = 99002
Season123Event.GuideEntryOtherViewClose = 99003
Season123Event.EnterMainEpiosdeHeroGroupView = 99004
Season123Event.StageRewardGet = 99005
Season123Event.CardDetailSwitch = 99006
Season123Event.GuideStageShow = 99007

return Season123Event
