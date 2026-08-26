-- chunkname: @modules/logic/tower/defines/TowerEvent.lua

module("modules.logic.tower.defines.TowerEvent", package.seeall)

local TowerEvent = _M

TowerEvent.SelectPermanentAltitude = 10000
TowerEvent.SelectPermanentEpisode = 10001
TowerEvent.TowerTaskUpdated = 10002
TowerEvent.OnTaskRewardGetFinish = 10003
TowerEvent.OnTowerResetSubEpisode = 10004
TowerEvent.TowerMopUp = 10005
TowerEvent.TowerRefreshTask = 10006
TowerEvent.FoldCurStage = 10007
TowerEvent.UnFoldMaxStage = 10008
TowerEvent.PermanentTowerFinishLayer = 10009
TowerEvent.PermanentSelectNextLayer = 10010
TowerEvent.DailyReresh = 10011
TowerEvent.SelectTalentItem = 10100
TowerEvent.ResetTalent = 10101
TowerEvent.ActiveTalent = 10102
TowerEvent.LocalKeyChange = 10103
TowerEvent.RefreshTowerReddot = 10104
TowerEvent.TowerUpdate = 10105
TowerEvent.RefreshTalent = 10106
TowerEvent.ChangeTalentPlan = 10107
TowerEvent.RenameTalentPlan = 10108
TowerEvent.OnHandleInStoreView = 10109
TowerEvent.OnEnterStoreView = 10110
TowerEvent.OnSelectDeepLayer = 20000
TowerEvent.OnEnterDeepGuide = 20001
TowerEvent.OnLoadTeamSuccess = 20002
TowerEvent.OnSaveTeamSuccess = 20003
TowerEvent.OnTowerDeepReset = 20004
TowerEvent.TowerDeepRefreshTask = 20005
TowerEvent.OnDeepTaskRewardGetFinish = 20006
TowerEvent.OnEnterDeepSuccRewardGuide = 20007
TowerEvent.OnCloseEnterDeepGuideView = 20008
TowerEvent.OnShowAssistBossEmpty = 20009
TowerEvent.OnSuccRewardGetFinish = 20010
TowerEvent.OnSelectHeroTrialItem = 30000

return TowerEvent
