-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/main/controller/LaplaceForumController.lua

module("modules.logic.versionactivity3_4.laplaceforum.main.controller.LaplaceForumController", package.seeall)

local LaplaceForumController = class("LaplaceForumController", BaseController)

function LaplaceForumController:onInit()
	self:reInit()
end

function LaplaceForumController:reInit()
	self._hasGet = nil
end

function LaplaceForumController:onInitFinish()
	return
end

function LaplaceForumController:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function LaplaceForumController:_onDailyRefresh()
	self._hasGet = nil

	self:onRefreshActivity()
end

function LaplaceForumController:onRefreshActivity()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_4Enum.ActivityId.LaplaceTowerAlbum]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		Activity101Rpc.instance:sendGet101InfosRequest(VersionActivity3_4Enum.ActivityId.LaplaceTowerAlbum)
	end

	self._hasGet = couldGet
end

function LaplaceForumController:openLaplaceForumMainView()
	ViewMgr.instance:openView(ViewName.LaplaceForumMainView)
end

function LaplaceForumController:openLaplaceMiniPartyView()
	ViewMgr.instance:openView(ViewName.MiniPartyView)
end

function LaplaceForumController:openLaplaceMiniPartyInviteView(param)
	ViewMgr.instance:openView(ViewName.MiniPartyInviteView, param)
end

function LaplaceForumController:openLaplaceObserverBoxView()
	ViewMgr.instance:openView(ViewName.ObserverBoxView)
end

function LaplaceForumController:openLaplaceChatRoomView()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	Activity225Rpc.instance:sendAct225EnterChatRoomRequest(actId, self.enterChatRoom, self)
end

function LaplaceForumController:enterChatRoom(_, resultCode, _)
	if resultCode == 0 then
		ChatRoomModel.instance:setHideLoadingDescState(true)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
		GameSceneMgr.instance:startScene(SceneType.ChatRoom, 1, 1, true)
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	end
end

function LaplaceForumController:_onEnterOneSceneFinish(sceneType, sceneId)
	ChatRoomModel.instance:setHideLoadingDescState(false)

	if sceneType == SceneType.ChatRoom then
		ViewMgr.instance:openView(ViewName.ChatRoomMainView)
	end
end

function LaplaceForumController:exitChatRoom()
	if ChatRoomModel.instance:checkIsInRoom() then
		local actId = ChatRoomModel.instance:getCurActivityId()

		Activity225Rpc.instance:sendAct225LeaveChatRoomRequest(actId)
	end

	ChatRoomModel.instance:setHideLoadingDescState(true)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
	SceneHelper.instance:waitSceneDone(SceneType.Main, self._onEnterMainSceneDone, self)
	MainController.instance:enterMainScene()
end

function LaplaceForumController:_onEnterMainSceneDone(sceneType, sceneId)
	ChatRoomModel.instance:setHideLoadingDescState(false)
	self:openLaplaceForumMainView()
end

function LaplaceForumController:openLaplaceTitleAppointmentView()
	ViewMgr.instance:openView(ViewName.TitleAppointmentView)
end

LaplaceForumController.instance = LaplaceForumController.New()

return LaplaceForumController
