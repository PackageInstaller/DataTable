-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomMainViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomMainViewContainer", package.seeall)

local ChatRoomMainViewContainer = class("ChatRoomMainViewContainer", BaseViewContainer)

function ChatRoomMainViewContainer:buildViews()
	local views = {}

	table.insert(views, ChatRoomMainView.New())

	self.npcListView = ChatRoomNpcListView.New()

	table.insert(views, self.npcListView)
	table.insert(views, ChatRoomPlayerListView.New())
	table.insert(views, ChatRoomSceneMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function ChatRoomMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonsView:setOverrideHelp(self._onHelpClick, self)
		self._navigateButtonsView:setOverrideClose(self.overrideClose, self)
		self._navigateButtonsView:setOverrideHome(self.overrideHome, self)

		return {
			self._navigateButtonsView
		}
	end
end

function ChatRoomMainViewContainer:overrideClose()
	LaplaceForumController.instance:exitChatRoom()
	self:closeThis()
end

function ChatRoomMainViewContainer:overrideHome()
	if ChatRoomModel.instance:checkIsInRoom() then
		local actId = ChatRoomModel.instance:getCurActivityId()

		Activity225Rpc.instance:sendAct225LeaveChatRoomRequest(actId)
	end

	NavigateButtonsView.homeClick()
end

function ChatRoomMainViewContainer:_onHelpClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.LaplaceChatRoomTipTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.LaplaceChatRoomTipDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function ChatRoomMainViewContainer:getNpcListView()
	return self.npcListView
end

function ChatRoomMainViewContainer:onContainerOpenFinish()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
end

function ChatRoomMainViewContainer:_onRefreshActivity()
	local status = ActivityHelper.getActivityStatus(VersionActivity3_4Enum.ActivityId.LaplaceMain)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function ChatRoomMainViewContainer:onContainerClose()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
end

return ChatRoomMainViewContainer
