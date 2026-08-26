-- chunkname: @modules/logic/versionactivity3_4/enter/view/VersionActivity3_4EnterView.lua

module("modules.logic.versionactivity3_4.enter.view.VersionActivity3_4EnterView", package.seeall)

local VersionActivity3_4EnterView = class("VersionActivity3_4EnterView", VersionActivityFixedEnterView)

function VersionActivity3_4EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self._godrag = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/#go_drag")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.viewPortWidth = recthelper.getWidth(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity3_4EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_4EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrolltab.gameObject)
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
end

function VersionActivity3_4EnterView:childAddEvents()
	VersionActivity3_4EnterView.super.childAddEvents(self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onBeginDrag, self)
		self._drag:AddDragEndListener(self._onEndDrag, self)
	end
end

function VersionActivity3_4EnterView:childRemoveEvents()
	VersionActivity3_4EnterView.super.childRemoveEvents(self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end
end

function VersionActivity3_4EnterView:_onBeginDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(true)
		end
	end
end

function VersionActivity3_4EnterView:_onEndDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(false)
		end
	end
end

function VersionActivity3_4EnterView:onOpen()
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local go = tabSetting.go

		gohelper.setActive(go, false)
	end

	gohelper.setActive(self._goActivityLine, false)
	self:initViewParam()
	self:createActivityTabItem()
	self:playVideo()
	self:refreshUI()
	self:refreshRedDot()
	self:refreshBtnVisible(true)

	local actId = self.viewContainer:getFirstOpenActId()

	if actId then
		self:focusActivityTabItem(actId)
	end
end

function VersionActivity3_4EnterView:focusActivityTabItem(actId)
	local activityItem = self.activityTabItemDict[actId]

	if activityItem then
		local tabGo = activityItem.go
		local sibling = gohelper.getSibling(tabGo)

		if sibling > 3 then
			recthelper.setAnchorY(self.rectTrContent, (sibling - 1) * 160)
		end
	end
end

local VIDEO_DURATION = 9

function VersionActivity3_4EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.gosubviewCanvasGroup.alpha = 0

		gohelper.setActive(self._goblock, true)
		VideoController.instance:openFullScreenVideoView(VersionActivity3_4Enum.EnterAnimVideoName, nil, VIDEO_DURATION)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_4Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

		self._open1AudioId = AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_open_1)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
		gohelper.setActive(self._goblock, false)

		self._openAudioId = AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_open_2)
	end
end

function VersionActivity3_4EnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.gosubviewCanvasGroup.alpha = 1

	if self.viewAnim.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_4EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_4Enum.OpenAnimDelayTime)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity3_4EnterView:_playOpen1Anim()
	self.gosubviewCanvasGroup.alpha = 1

	gohelper.setActive(self._goblock, true)

	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
	TaskDispatcher.runDelay(self._playFinishOpen1Anim, self, VersionActivity3_4Enum.Open1AnimTime)
end

function VersionActivity3_4EnterView:_playFinishOpen1Anim()
	gohelper.setActive(self._goblock, false)
end

function VersionActivity3_4EnterView:_playOpenAnim(animName)
	if not string.nilorempty(animName) then
		self.viewAnim:Play(animName, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity3_4EnterView:onDestroyView()
	VersionActivity3_4EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	TaskDispatcher.cancelTask(self._playFinishOpen1Anim, self)

	if ViewMgr.instance:isOpen(ViewName.FullScreenVideoView) then
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	end

	if self._open1AudioId then
		AudioMgr.instance:stopPlayingID(self._open1AudioId)
	end

	if self._openAudioId then
		AudioMgr.instance:stopPlayingID(self._openAudioId)
	end
end

return VersionActivity3_4EnterView
