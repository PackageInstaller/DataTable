-- chunkname: @modules/logic/limited/view/LimitedRoleView.lua

module("modules.logic.limited.view.LimitedRoleView", package.seeall)

local LimitedRoleView = class("LimitedRoleView", BaseView)

function LimitedRoleView:onInitView()
	self._startTime = Time.time
	self._clickMask = gohelper.findChildClick(self.viewGO, "clickMask")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._videoGO = gohelper.findChild(self.viewGO, "#go_video")

	gohelper.setActive(self._btnSkip.gameObject, false)
end

function LimitedRoleView:addEvents()
	self._clickMask:AddClickListener(self._onClickMask, self)
	self._btnSkip:AddClickListener(self._onClickBtnSkip, self)
end

function LimitedRoleView:removeEvents()
	self._clickMask:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
end

function LimitedRoleView:_onClickMask()
	if Time.time - self._startTime > 2 and not self._hasPlayFinish then
		gohelper.setActive(self._btnSkip.gameObject, true)
	end
end

function LimitedRoleView:_onClickBtnSkip()
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.ManualSkip)
	self:closeThis()
end

function LimitedRoleView:_stopMainBgm()
	AudioBgmManager.instance:stopBgm(self._stopBgm)
end

function LimitedRoleView:onOpen()
	self._startTime = Time.time
	self._hasPlayFinish = false

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)

	self._limitCO = self.viewParam.limitedCO
	self._stopBgm = self.viewParam.stopBgm

	if self._stopBgm then
		self:_stopMainBgm()
		TaskDispatcher.runRepeat(self._stopMainBgm, self, 0.2, 100)
	end

	if self._limitCO then
		if not self._videoPlayer then
			self._videoPlayer, self._videoPlayerGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._videoGO)

			local uiVideoAdapter = MonoHelper.addNoUpdateLuaComOnceToGo(self._videoPlayerGO, FullScreenVideoAdapter)

			self._videoPlayerGO = nil
		end

		self._videoPlayer:play(self._limitCO.entranceMv, false, self._videoStatusUpdate, self)

		if self._limitCO.mvtime and self._limitCO.mvtime > 0 then
			TaskDispatcher.runDelay(self._timeout, self, self._limitCO.mvtime)
		end
	else
		logError("open viewParam limitCO = null")
		TaskDispatcher.runDelay(self.closeThis, self, 1)
	end
end

function LimitedRoleView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._timeout, self)

	if self._stopBgm then
		TaskDispatcher.cancelTask(self._stopMainBgm, self)
	end

	if self._limitCO and self._limitCO.stopAudio > 0 then
		AudioMgr.instance:trigger(self._limitCO.stopAudio)
	end
end

function LimitedRoleView:_onEscBtnClick()
	return
end

function LimitedRoleView:_timeout()
	if isDebugBuild then
		logError("播放入场视频超时")
	end

	self:_dispatchPlayActionAndDelayClose()
end

function LimitedRoleView:_videoStatusUpdate(path, status, errorCode)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.VideoState, status)

	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(self._timeout, self)
		self:_onPlayMovieFinish()
	end

	if (status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.StartedSeeking) and self._limitCO and self._limitCO.audio > 0 then
		AudioMgr.instance:trigger(self._limitCO.audio)
	end
end

function LimitedRoleView:_stopMovie()
	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end
end

function LimitedRoleView:_onPlayMovieFinish()
	self._hasPlayFinish = true

	gohelper.setActive(self._btnSkip.gameObject, false)
	self:_dispatchPlayActionAndDelayClose()
end

function LimitedRoleView:_dispatchPlayActionAndDelayClose()
	TaskDispatcher.runDelay(self._delayCloseThis, self, 0.2)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.PlayAction)
end

function LimitedRoleView:_delayCloseThis()
	TaskDispatcher.cancelTask(self._delayCloseThis, self)

	if self._videoPlayer then
		self._videoPlayer:stop()
	end

	self:closeThis()
end

function LimitedRoleView:onDestroyView()
	NavigateMgr.instance:removeEscape(self.viewName)
	self:_stopMovie()
end

return LimitedRoleView
