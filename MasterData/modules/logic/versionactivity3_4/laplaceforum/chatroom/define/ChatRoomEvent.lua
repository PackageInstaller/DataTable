-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/define/ChatRoomEvent.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.define.ChatRoomEvent", package.seeall)

local ChatRoomEvent = _M

ChatRoomEvent.OnLucyRainBack = GameUtil.getUniqueTb()
ChatRoomEvent.OnFingerGameBack = GameUtil.getUniqueTb()
ChatRoomEvent.OnQAndABack = GameUtil.getUniqueTb()
ChatRoomEvent.OnShowNpcPlayerType = GameUtil.getUniqueTb()
ChatRoomEvent.OnStartNextGame = GameUtil.getUniqueTb()
ChatRoomEvent.OnTriggerPlayerSelectCard = GameUtil.getUniqueTb()
ChatRoomEvent.OnPlayerPlayACard = GameUtil.getUniqueTb()
ChatRoomEvent.OnPlayerPlayCardAnimEnd = GameUtil.getUniqueTb()
ChatRoomEvent.OnFlipCardBoth = GameUtil.getUniqueTb()
ChatRoomEvent.OnTriggerPlayerDiscard = GameUtil.getUniqueTb()
ChatRoomEvent.OnPlayerDiscard = GameUtil.getUniqueTb()
ChatRoomEvent.OnTriggerDiscardFlipAnim = GameUtil.getUniqueTb()
ChatRoomEvent.OnTriggerDiscardFlipAnimRefresh = GameUtil.getUniqueTb()
ChatRoomEvent.OnTriggerGameSettle = GameUtil.getUniqueTb()
ChatRoomEvent.OnTriggerGameSettle_2 = GameUtil.getUniqueTb()
ChatRoomEvent.OnSetAIDialog = GameUtil.getUniqueTb()
ChatRoomEvent.OnInfoUpdate = GameUtil.getUniqueTb()
ChatRoomEvent.ShowChatEmoji = GameUtil.getUniqueTb()
ChatRoomEvent.OnChatRoomUserInfoChange = GameUtil.getUniqueTb()
ChatRoomEvent.OnNpcLoadFinish = GameUtil.getUniqueTb()
ChatRoomEvent.DailyReresh = GameUtil.getUniqueTb()

return ChatRoomEvent
