-- chunkname: @modules/logic/summon/controller/SummonEvent.lua

module("modules.logic.summon.controller.SummonEvent", package.seeall)

local SummonEvent = _M

SummonEvent.onSummonReply = 1
SummonEvent.onSummonFailed = 2
SummonEvent.summonShowBlackScreen = 5
SummonEvent.summonCloseBlackScreen = 6
SummonEvent.summonMainCloseImmediately = 7
SummonEvent.summonShowExitAnim = 8
SummonEvent.onViewCanPlayEnterAnim = 11
SummonEvent.onSummonAnimShowGuide = 104
SummonEvent.onSummonAnimEnterDraw = 100
SummonEvent.onSummonDraw = 101
SummonEvent.onSummonAnimRareEffect = 102
SummonEvent.onSummonAnimEnd = 103
SummonEvent.onRemainTimeCountdown = 110
SummonEvent.onSummonResultClose = 201
SummonEvent.onSummonEquipEnd = 202
SummonEvent.onSummonEquipSingleFinish = 203
SummonEvent.onSummonPoolDetailCategoryClick = 301
SummonEvent.onSummonTabSet = 401
SummonEvent.onSummonInfoGot = 402
SummonEvent.onSummonSkip = 403
SummonEvent.GuideEquipPool = 501
SummonEvent.guideScrollShowEquipPool = 502
SummonEvent.LuckyBagViewOpen = 503
SummonEvent.onGetSummonPoolHistoryData = 601
SummonEvent.onSummonPoolHistorySummonRequest = 602
SummonEvent.onSummonPoolHistorySelect = 603
SummonEvent.onNewPoolChanged = 701
SummonEvent.onLuckyBagOpened = 801
SummonEvent.onLuckyListChanged = 802
SummonEvent.onCustomPicked = 901
SummonEvent.onCustomPickListChanged = 902
SummonEvent.onSummonScenePrepared = 1001
SummonEvent.onSummonProgressRewards = 2001
SummonEvent.onReceiveSummonReply = 2002
SummonEvent.onSummonPoolPackageRedDotChange = 3003
SummonEvent.onLimitationReplicationSelectHero = 4001
SummonEvent.onSummonInfallibleStatusChange = 5001
SummonEvent.onSummonOptionalProgressRewards = 5002
SummonEvent.onSummonPoolPackageProp = 5003

return SummonEvent
