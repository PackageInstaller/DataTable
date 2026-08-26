-- chunkname: @modules/logic/versionactivity3_1/enter/view/VersionActivity3_1EnterView.lua

module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterView", package.seeall)

local VersionActivity3_1EnterView = class("VersionActivity3_1EnterView", VersionActivityFixedEnterView)

function VersionActivity3_1EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity3_1EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_1EnterViewTabItem2)
	self:setActivityLineGo(self._goline)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function VersionActivity3_1EnterView:onOpen()
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local go = tabSetting.go

		gohelper.setActive(go, false)
	end

	gohelper.setActive(self._goActivityLine, false)
	self:initViewParam()
	self:createActivityTabItem()

	if self.curActId == VersionActivity3_1Enum.ActivityId.Dungeon and not self.viewParam.isExitFight then
		self:playVideo()
	end

	self:refreshUI()
	self:refreshRedDot()
	self:refreshBtnVisible(true)
end

local VIDEO_DURATION = 8

function VersionActivity3_1EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.cgviewgo = self.viewGO:GetComponent(gohelper.Type_CanvasGroup)

		if self.cgviewgo then
			self.cgviewgo.interactable = false
		end

		self.gosubviewCanvasGroup.alpha = 0

		AudioMgr.instance:trigger(AudioEnum3_1.VersionActivity3_1Enter.play_ui_mingdi_video)
		VideoController.instance:openFullScreenVideoView(langVideoUrl(VersionActivity3_1Enum.EnterAnimVideoName), nil, VIDEO_DURATION)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_1Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
	end
end

function VersionActivity3_1EnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	self.gosubviewCanvasGroup.alpha = 1

	if self.cgviewgo then
		self.cgviewgo.interactable = true
	end

	if self.viewAnim.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_1EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, 4)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity3_1EnterView:_playOpen1Anim()
	self.gosubviewCanvasGroup.alpha = 1
	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity3_1EnterView:_playOpenAnim(animNim)
	if not string.nilorempty(animNim) then
		self.viewAnim:Play(animNim, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity3_1EnterView:onDestroyView()
	VersionActivity3_1EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

return VersionActivity3_1EnterView
