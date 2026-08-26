-- chunkname: @modules/logic/versionactivity/view/VersionActivityVideoView.lua

module("modules.logic.versionactivity.view.VersionActivityVideoView", package.seeall)

local VersionActivityVideoView = class("VersionActivityVideoView", BaseView)

function VersionActivityVideoView:onInitView()
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_block")
	self._gorightbtn = gohelper.findChild(self.viewGO, "#go_rightbtn")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rightbtn/#btn_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityVideoView:addEvents()
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function VersionActivityVideoView:removeEvents()
	self._btnblock:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

function VersionActivityVideoView:_btnblockOnClick()
	gohelper.setActive(self._gorightbtn, true)
	TaskDispatcher.cancelTask(self.hideRightBtn, self)
	TaskDispatcher.runDelay(self.hideRightBtn, self, 10)
end

function VersionActivityVideoView:_btnskipOnClick()
	self._videoPlayer:Pause()
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
		self:closeThis()
	end, function()
		self._videoPlayer:playLoadMedia()
	end)
end

function VersionActivityVideoView:_editableInitView()
	self:hideRightBtn()

	self._goVideoPlayer = gohelper.findChild(self.viewGO, "VideoPlayer")
	self._videoPlayer = VideoPlayerMgr.instance:createVideoPlayer(self._goVideoPlayer)

	self._videoPlayer:setScaleMode(UnityEngine.ScaleMode.ScaleAndCrop)
	self._videoPlayer:setEventListener(self._videoStatusUpdate, self)
	NavigateMgr.instance:addEscape(ViewName.VersionActivityVideoView, self._btnskipOnClick, self)
end

function VersionActivityVideoView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		self:closeThis()
	end
end

function VersionActivityVideoView:initViewParam()
	self.actId = self.viewParam.actId
	self.firstEnter = self.viewParam.firstEnter
	self.activityIdList = self.viewParam.activityIdList
	self.doneOpenViewName = self.viewParam.doneOpenViewName
	self.closeCallback = self.viewParam.closeCallback
	self.closeCallbackObj = self.viewParam.closeCallbackObj
end

function VersionActivityVideoView:onUpdateParam()
	return
end

function VersionActivityVideoView:onOpen()
	self:initViewParam()

	local actCo = lua_activity105.configDict[self.actId]

	if not actCo or string.nilorempty(actCo.pv) then
		logError(string.format("not found actId ：%s config pv", self.actId))
		self:closeThis()
	end

	self._videoPlayer:loadMedia(actCo.pv)
	self._videoPlayer:playLoadMedia()
end

function VersionActivityVideoView:hideRightBtn()
	gohelper.setActive(self._gorightbtn, false)
end

function VersionActivityVideoView:closeThis()
	if not self.firstEnter then
		self:_closeThis()

		return
	end

	for _, actId in ipairs(self.activityIdList) do
		local activityStatus = ActivityHelper.getActivityStatus(actId)

		if activityStatus == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(actId)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivityEnum.EnterViewActIdList, self.onReceiveReply, self)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	self.closeCallback(self.closeCallbackObj)
end

function VersionActivityVideoView:onOpenViewFinish(viewName)
	if viewName == self.doneOpenViewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

		self.openViewDone = true

		self:_checkCanCloseThisView()
	end
end

function VersionActivityVideoView:onReceiveReply()
	self.receiveMsgDone = true

	self:_checkCanCloseThisView()
end

function VersionActivityVideoView:_checkCanCloseThisView()
	if self.openViewDone and self.receiveMsgDone then
		self:_closeThis()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
	end
end

function VersionActivityVideoView:_closeThis()
	VersionActivityVideoView.super.closeThis(self)
end

function VersionActivityVideoView:onClose()
	return
end

function VersionActivityVideoView:onDestroyView()
	if self._videoPlayer then
		if not BootNativeUtil.isIOS() then
			self._videoPlayer:stop()
		end

		self._videoPlayer:clear()

		self._videoPlayer = nil
	end
end

return VersionActivityVideoView
