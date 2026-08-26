-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/controller/ChatRoomController.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.controller.ChatRoomController", package.seeall)

local ChatRoomController = class("ChatRoomController", BaseController)

function ChatRoomController:onInit()
	self:reInit()
end

function ChatRoomController:reInit()
	self._hasGet = nil
end

function ChatRoomController:onInitFinish()
	return
end

function ChatRoomController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.sendGetAct225InfoRequest, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function ChatRoomController:_onDailyRefresh()
	self:sendGetAct225InfoRequest(true)
end

function ChatRoomController:sendGetAct225InfoRequest(isDaily)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_4Enum.ActivityId.LaplaceChatRoom]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and isDaily and self._hasGet ~= couldGet then
		Activity225Rpc.instance:sendGetAct225InfoRequest(VersionActivity3_4Enum.ActivityId.LaplaceChatRoom, self.doDailyRefresh, self)

		self._hasGet = couldGet

		return
	end

	if couldGet and self._hasGet ~= couldGet then
		Activity225Rpc.instance:sendGetAct225InfoRequest(VersionActivity3_4Enum.ActivityId.LaplaceChatRoom)
	end

	self._hasGet = couldGet
end

function ChatRoomController:doDailyRefresh()
	self:dispatchEvent(ChatRoomEvent.DailyReresh)
end

function ChatRoomController:openNpcPlayerInfoView(playerInfo, playerSelf, heroCover)
	local param = {}

	param.mo = playerInfo

	ViewMgr.instance:openView(ViewName.ChatRoomNpcPlayerInfoView, param)
end

function ChatRoomController:openNpcEasterEggView(eggId)
	ViewMgr.instance:openView(ViewName.ChatRoomNpcEasterEggView, eggId)
end

function ChatRoomController:openNpcQAndAView(questionId)
	ViewMgr.instance:openView(ViewName.ChatRoomNpcQAndAView, questionId)
end

function ChatRoomController:openChatRoomLuckyRainView()
	ViewMgr.instance:openView(ViewName.ChatRoomLuckyRainView)
end

function ChatRoomController:openChatRoomFingerGameView()
	ViewMgr.instance:openView(ViewName.ChatRoomFingerGamePlayView)
end

function ChatRoomController:openChatRoomFingerGameResultView()
	ViewMgr.instance:openView(ViewName.ChatRoomFingerGameResultView)
end

function ChatRoomController:showPlayCardTip(param)
	ViewMgr.instance:openView(ViewName.ChatRoomFingerGamePromptView, param)
end

function ChatRoomController:closePlayCardTip()
	ViewMgr.instance:closeView(ViewName.ChatRoomFingerGamePromptView)
end

function ChatRoomController:exiteGame()
	ViewMgr.instance:closeView(ViewName.ChatRoomFingerGamePlayView)
end

ChatRoomController.instance = ChatRoomController.New()

return ChatRoomController
