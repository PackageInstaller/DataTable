-- chunkname: @modules/logic/versionactivity3_9/enter/view/VersionActivity3_9EnterView.lua

module("modules.logic.versionactivity3_9.enter.view.VersionActivity3_9EnterView", package.seeall)

local VersionActivity3_9EnterView = class("VersionActivity3_9EnterView", VersionActivityFixedEnterView)

function VersionActivity3_9EnterView:_editableInitView()
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

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity3_9EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_9EnterViewTabItem2)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/widget_layout_horizontal/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/widget_layout_horizontal/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/widget_layout_horizontal/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)

	gohelper.setActive(self._goActivityLine, false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrolltab.gameObject)
end

function VersionActivity3_9EnterView:childAddEvents()
	VersionActivity3_9EnterView.super.childAddEvents(self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onBeginDrag, self)
		self._drag:AddDragEndListener(self._onEndDrag, self)
	end
end

function VersionActivity3_9EnterView:childRemoveEvents()
	VersionActivity3_9EnterView.super.childRemoveEvents(self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end
end

function VersionActivity3_9EnterView:_onBeginDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(true)
		end
	end
end

function VersionActivity3_9EnterView:_onEndDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(false)
		end
	end
end

function VersionActivity3_9EnterView:onOpen()
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
end

function VersionActivity3_9EnterView:onClose()
	VersionActivity3_9EnterView.super.onClose(self)

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end
end

local VIDEO_DURATION = 6.5

function VersionActivity3_9EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam.jumpActId and self.viewParam.jumpActId ~= VersionActivity3_9Enum.ActivityId.Dungeon then
		return
	end

	if self.viewParam.isExitFight then
		return
	end

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.gosubviewCanvasGroup.alpha = 0

		local isCanSkip = GameUtil.playerPrefsGetNumberByUserId(VersionActivity3_9Enum.EnterVideoFirstKey, 0) ~= 0

		if not isCanSkip then
			GameUtil.playerPrefsSetNumberByUserId(VersionActivity3_9Enum.EnterVideoFirstKey, 1)
		end

		AudioMgr.instance:trigger(AudioEnum3_9.EnterView.play_ui_chongran_3_9_open)
		VideoController.instance:openFullScreenVideoView(VersionActivity3_9Enum.EnterAnimVideoName, nil, VIDEO_DURATION, nil, nil, {
			couldSkip = isCanSkip
		})
		TimeUtil.setDayFirstLoginRed(VersionActivity3_9Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
	end
end

function VersionActivity3_9EnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.gosubviewCanvasGroup.alpha = 1

	if self.viewAnim.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_9EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_9Enum.OpenAnimDelayTime)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity3_9EnterView:_playOpen1Anim()
	self.gosubviewCanvasGroup.alpha = 1
	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity3_9EnterView:_playOpenAnim(animName)
	if not string.nilorempty(animName) then
		self.viewAnim:Play(animName, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity3_9EnterView:onDestroyView()
	VersionActivity3_9EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if ViewMgr.instance:isOpen(ViewName.FullScreenVideoView) then
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	end
end

return VersionActivity3_9EnterView
