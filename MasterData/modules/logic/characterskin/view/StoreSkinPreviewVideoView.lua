-- chunkname: @modules/logic/characterskin/view/StoreSkinPreviewVideoView.lua

module("modules.logic.characterskin.view.StoreSkinPreviewVideoView", package.seeall)

local StoreSkinPreviewVideoView = class("StoreSkinPreviewVideoView", BaseView)

function StoreSkinPreviewVideoView:onInitView()
	self._startTime = Time.time
	self._videoRoot = gohelper.findChild(self.viewGO, "video")
	self._clickMask = gohelper.findChildClick(self._videoRoot, "clickMask")
	self._btnSkip = gohelper.findChildButtonWithAudio(self._videoRoot, "#btn_skip")
	self._videoGO = gohelper.findChild(self._videoRoot, "#go_video")

	gohelper.setActive(self._btnSkip.gameObject, false)
end

function StoreSkinPreviewVideoView:addEvents()
	self._clickMask:AddClickListener(self._onClickMask, self)
	self._btnSkip:AddClickListener(self._onClickBtnSkip, self)
end

function StoreSkinPreviewVideoView:removeEvents()
	self._clickMask:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
end

function StoreSkinPreviewVideoView:_onClickMask()
	if not self._hasPlayFinish then
		gohelper.setActive(self._btnSkip.gameObject, true)
	end
end

function StoreSkinPreviewVideoView:_onClickBtnSkip()
	self:_stopMovie()
end

function StoreSkinPreviewVideoView:onOpen()
	self._skinGoodMo = self.viewParam.goodsMO

	local product = self._skinGoodMo.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinConfig = lua_skin.configDict[skinId]

	local skinViewCfg = lua_character_limited.configDict[skinId]

	if not skinViewCfg or VersionValidator.instance:isInReviewing() then
		self:checkVideoGuide()

		return
	end

	self._startTime = Time.time
	self._hasPlayFinish = false

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)

	if not skinViewCfg then
		return
	else
		self._videoAudioId = skinViewCfg.audio
		self._stopAudioId = skinViewCfg.stopAudio
		self._stopBgm = self._videoAudioId > 0
		self._videoPath = string.nilorempty(skinViewCfg.entranceMv) and "" or skinViewCfg.entranceMv
		self._mvTime = skinViewCfg.mvtime
	end

	if self._stopBgm then
		self:_stopMainBgm()
		TaskDispatcher.runDelay(self._stopMainBgm, self, 0.5)
	end

	gohelper.setActive(self._videoRoot, true)

	if not string.nilorempty(self._videoPath) then
		if not self._videoPlayer then
			self._videoPlayer, self._videoPlayerGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._videoGO)

			local uiVideoAdapter = MonoHelper.addNoUpdateLuaComOnceToGo(self._videoPlayerGO, FullScreenVideoAdapter)

			self._videoPlayerGO = nil
		end

		self._videoPlayer:play(self._videoPath, false, self._videoStatusUpdate, self)

		if self._mvTime and self._mvTime > 0 then
			TaskDispatcher.runDelay(self._timeout, self, self._mvTime)
		end
	else
		TaskDispatcher.runDelay(self._hideVideoGo, self, 1)
	end
end

function StoreSkinPreviewVideoView:checkVideoGuide()
	if self.skinConfig and self.skinConfig.isSkinVideo then
		CharacterController.instance:dispatchEvent(CharacterEvent.onClientVideoPlayFinish)
	end
end

function StoreSkinPreviewVideoView:onClose()
	TaskDispatcher.cancelTask(self._timeout, self)
	TaskDispatcher.cancelTask(self._hideVideoGo, self)
	TaskDispatcher.cancelTask(self._stopMainBgm, self)

	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end
end

function StoreSkinPreviewVideoView:_onEscBtnClick()
	return
end

function StoreSkinPreviewVideoView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(self._timeout, self)
		self:_playMovieFinish()
	end

	if (status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.StartedSeeking) and self._videoAudioId > 0 then
		AudioMgr.instance:trigger(self._videoAudioId)
	end
end

function StoreSkinPreviewVideoView:_timeout()
	if isDebugBuild then
		logError("播放入场视频超时")
	end

	self:_stopMovie()
end

function StoreSkinPreviewVideoView:_stopMovie()
	NavigateMgr.instance:removeEscape(self.viewName)
	self:_hideVideoGo()

	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(self._timeout, self)

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	self:_playMainBgm()
end

function StoreSkinPreviewVideoView:_playMovieFinish()
	self._hasPlayFinish = true

	self:_hideVideoGo()
	NavigateMgr.instance:removeEscape(self.viewName)

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	self:_playMainBgm()
end

function StoreSkinPreviewVideoView:_playMainBgm()
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
	end
end

function StoreSkinPreviewVideoView:_stopMainBgm()
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
	end
end

function StoreSkinPreviewVideoView:_hideVideoGo()
	gohelper.setActive(self._videoRoot, false)
	self:checkVideoGuide()
end

return StoreSkinPreviewVideoView
