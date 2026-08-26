-- chunkname: @modules/logic/versionactivity3_2/enter/view/VersionActivity3_2EnterView.lua

module("modules.logic.versionactivity3_2.enter.view.VersionActivity3_2EnterView", package.seeall)

local VersionActivity3_2EnterView = class("VersionActivity3_2EnterView", VersionActivityFixedEnterView)

function VersionActivity3_2EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.viewPortWidth = recthelper.getWidth(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivityFixedEnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity3_2EnterViewTabItem2)
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

function VersionActivity3_2EnterView:onOpen()
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

local VIDEO_DURATION = 8

function VersionActivity3_2EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.cgviewgo = self.viewGO:GetComponent(gohelper.Type_CanvasGroup)

		if self.cgviewgo then
			self.cgviewgo.interactable = false
		end

		self.gosubviewCanvasGroup.alpha = 0

		VideoController.instance:openFullScreenVideoView(langVideoUrl(VersionActivity3_2Enum.EnterAnimVideoName), nil, VIDEO_DURATION)
		TimeUtil.setDayFirstLoginRed(VersionActivity3_2Enum.EnterVideoDayKey)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		AudioMgr.instance:trigger(AudioEnum3_2.VersionActivity3_2.play_ui_shengyan_open_1)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
		AudioMgr.instance:trigger(AudioEnum3_2.VersionActivity3_2.play_ui_shengyan_open_2)
	end
end

function VersionActivity3_2EnterView:onPlayVideoDone()
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

function VersionActivity3_2EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, 4)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity3_2EnterView:_playOpen1Anim()
	self.gosubviewCanvasGroup.alpha = 1
	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity3_2EnterView:_playOpenAnim(animNim)
	if not string.nilorempty(animNim) then
		self.viewAnim:Play(animNim, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity3_2EnterView:onDestroyView()
	VersionActivity3_2EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

function VersionActivity3_2EnterView:sortTabItemList()
	VersionActivity3_2EnterView.super.sortTabItemList(self)
	self:_changePos()
end

function VersionActivity3_2EnterView:_changePos()
	gohelper.setActive(self._goActivityLine, false)
	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	self._posIndex = 0
	self._contentWidth = 210

	for _, actId in ipairs(self.openActIdList) do
		local activityItem = self.activityTabItemDict[actId]

		self:_setPos(activityItem.go)
	end

	for _, actId in ipairs(self.noOpenActList) do
		local activityItem = self.activityTabItemDict[actId]

		self:_setPos(activityItem.go)
	end

	self.rectTrContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = false

	recthelper.setWidth(self.rectTrContent, self._contentWidth)
end

function VersionActivity3_2EnterView:_setPos(go)
	self._posIndex = self._posIndex + 1

	local x = self._contentWidth

	self._contentWidth = self._contentWidth + recthelper.getWidth(go.transform)

	local layoutElement = gohelper.onceAddComponent(go, typeof(UnityEngine.UI.LayoutElement))

	layoutElement.enabled = true
	layoutElement.ignoreLayout = true

	if self._posIndex == 1 then
		transformhelper.setLocalPosXY(go.transform, x, 90)

		self._contentWidth = self._contentWidth - 65

		return
	end

	if self._posIndex == 2 then
		transformhelper.setLocalPosXY(go.transform, x, 0)

		return
	end

	local index = self._posIndex % 2

	transformhelper.setLocalPosXY(go.transform, x, index == 1 and 30 or -30)
end

return VersionActivity3_2EnterView
