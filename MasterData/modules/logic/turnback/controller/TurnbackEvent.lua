-- chunkname: @modules/logic/turnback/controller/TurnbackEvent.lua

module("modules.logic.turnback.controller.TurnbackEvent", package.seeall)

local TurnbackEvent = {}

TurnbackEvent.RefreshBeginner = 1
TurnbackEvent.RefreshTaskRewardItem = 2
TurnbackEvent.OnTaskRewardGetFinish = 3
TurnbackEvent.AdditionCountChange = 4
TurnbackEvent.RefreshOnceBonusGetState = 5
TurnbackEvent.RefreshTaskRedDot = 6
TurnbackEvent.RefreshSignInScroll = 7
TurnbackEvent.RefreshRemainTime = 8
TurnbackEvent.RefreshView = 9
TurnbackEvent.RefreshSignInItem = 10
TurnbackEvent.RefreshProgressItem = 11
TurnbackEvent.AfterBuyDoubleReward = 12
TurnbackEvent.OnSignInReply = 13
TurnbackEvent.onCustomPickComplete = 14
TurnbackEvent.onCustomPickListChanged = 15
TurnbackEvent.TapViewOpenAnimBegin = 16
TurnbackEvent.TapViewCloseAnimBegin = 17
TurnbackEvent.OnTaskFinishAnim = 18
TurnbackEvent.AfterReceiveDayFree = 19
TurnbackEvent.FinishTaskItem = 20
TurnbackEvent.OnViewOpenFinish = 21
TurnbackEvent.OnTurnbackReturnRewardReply = 22
TurnbackEvent.OnRefreshReturnRewardTask = 23
TurnbackEvent.OnFinishReturnRewardRefreshAnim = 24

return TurnbackEvent
