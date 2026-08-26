-- chunkname: @modules/logic/bossrush/controller/BossRushEvent.lua

module("modules.logic.bossrush.controller.BossRushEvent", package.seeall)

local BossRushEvent = _M

BossRushEvent.OnScoreChange = 1
BossRushEvent.OnHpChange = 2
BossRushEvent.OnBloodCountChange = 3
BossRushEvent.OnBossDeadSumChange = 4
BossRushEvent.OnReceiveGet128InfosReply = 100
BossRushEvent.OnReceiveAct128GetTotalRewardsReply = 101
BossRushEvent.OnReceiveAct128DoublePointRequestReply = 102
BossRushEvent.OnReceiveAct128InfoUpdatePush = 103
BossRushEvent.OnUnlimitedHp = 104
BossRushEvent.OnReceiveGet128EvaluateReply = 1001
BossRushEvent.OnReceiveGet128SingleRewardReply = 1002
BossRushEvent.OnClickGetAllScheduleBouns = 1003
BossRushEvent.OnClickGetAllAchievementBouns = 1004
BossRushEvent.OnHandleInStoreView = 1005
BossRushEvent.OnEnterStoreView = 1006
BossRushEvent.OnClickGetAllSpecialScheduleBouns = 1007
BossRushEvent.OnSelectEnhanceRole = 1100
BossRushEvent.OnSelectV2a9SpItem = 1200
BossRushEvent.onReceiveAct128SpFirstHalfSelectItemReply = 1201
BossRushEvent.V3a2_BossRush_ResultAssess_AnimFinish = 3201
BossRushEvent.V3a2_BossRush_HandBook_SelectMonster = 3202
BossRushEvent.V3a2_BossRush_HandBook_SelectMonsterCB = 3203
BossRushEvent.onReceiveAct128GetExpReply = 3204

return BossRushEvent
