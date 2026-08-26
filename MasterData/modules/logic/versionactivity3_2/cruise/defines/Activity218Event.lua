-- chunkname: @modules/logic/versionactivity3_2/cruise/defines/Activity218Event.lua

module("modules.logic.versionactivity3_2.cruise.defines.Activity218Event", package.seeall)

local Activity218Event = _M

Activity218Event.OnMsgInfoChange = GameUtil.getUniqueTb()
Activity218Event.OnReceiveAcceptRewardReply = GameUtil.getUniqueTb()
Activity218Event.OnGameStart = GameUtil.getUniqueTb()
Activity218Event.OnStartNextGame = GameUtil.getUniqueTb()
Activity218Event.OnTriggerPlayerSelectCard = GameUtil.getUniqueTb()
Activity218Event.OnPlayerPlayACard = GameUtil.getUniqueTb()
Activity218Event.OnPlayerPlayCardAnimEnd = GameUtil.getUniqueTb()
Activity218Event.OnFlipCardBoth = GameUtil.getUniqueTb()
Activity218Event.OnTriggerPlayerDiscard = GameUtil.getUniqueTb()
Activity218Event.OnPlayerDiscard = GameUtil.getUniqueTb()
Activity218Event.OnTriggerDiscardFlipAnim = GameUtil.getUniqueTb()
Activity218Event.OnTriggerDiscardFlipAnimRefresh = GameUtil.getUniqueTb()
Activity218Event.OnTriggerGameSettle = GameUtil.getUniqueTb()
Activity218Event.OnTriggerGameSettle_2 = GameUtil.getUniqueTb()
Activity218Event.OnSetAIDialog = GameUtil.getUniqueTb()

return Activity218Event
