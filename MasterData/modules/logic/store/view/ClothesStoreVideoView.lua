-- chunkname: @modules/logic/store/view/ClothesStoreVideoView.lua

module("modules.logic.store.view.ClothesStoreVideoView", package.seeall)

local ClothesStoreVideoView = class("ClothesStoreVideoView", BaseView)

function ClothesStoreVideoView:onInitView()
	self._videoRoot = gohelper.findChild(self.viewGO, "#go_has/character/bg/video/videoRoot")
	self._videoGO = gohelper.findChild(self._videoRoot, "#go_video")
	self.viewCanvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ClothesStoreVideoView:addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.OnPlaySkinVideo, self._onPlaySkinVideo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OnPlaySkinVideoStore, self._onPlaySkinVideoStore, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OnCheckHideSkinVideo, self._onCheckHideSkillVideo, self)
end

function ClothesStoreVideoView:removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.OnPlaySkinVideo, self._onPlaySkinVideo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.OnPlaySkinVideoStore, self._onPlaySkinVideoStore, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.OnCheckHideSkinVideo, self._onCheckHideSkillVideo, self)
end

function ClothesStoreVideoView:_onPlaySkinVideo(goodsMo)
	self:playSkinVideo(goodsMo)
end

function ClothesStoreVideoView:_onPlaySkinVideoStore(goodsMo)
	self:playSkinVideo(goodsMo, true)
end

function ClothesStoreVideoView:_onCheckHideSkillVideo(goodsId)
	if goodsId ~= self._curPlayGoodsId and self._curPlayGoodsId ~= nil then
		self:_playMovieFinish()
	end
end

function ClothesStoreVideoView:onOpen()
	return
end

function ClothesStoreVideoView:playSkinVideo(goodsMo, isStoreMv)
	self._curPlayGoodsId = nil

	if not goodsMo then
		self:_stopMovie()

		return
	end

	local skinViewCfg = self:_getSkinViewCfgByGoodsMo(goodsMo)

	if not skinViewCfg or VersionValidator.instance:isInReviewing() then
		return
	end

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	local finishAnimName

	self._videoAudioId = 0
	self._stopAudioId = 0
	self._mvTime = 0

	if isStoreMv == true then
		self._videoPath = skinViewCfg.storeMv
		self._videoAudioId = skinViewCfg.storeMvAudio
		self._stopAudioId = skinViewCfg.storeMvStopAudio
		finishAnimName = "videoout"
	else
		NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)

		self._videoAudioId = skinViewCfg.audio
		self._stopAudioId = skinViewCfg.stopAudio
		self._mvTime = skinViewCfg.mvtime
		self._videoPath = string.nilorempty(skinViewCfg.entranceMv) and "" or skinViewCfg.entranceMv

		if not self._videoAudioId or self._videoAudioId == 0 then
			local limitedVoiceCfg = lua_character_limited_voice.configDict[skinViewCfg.id]

			if limitedVoiceCfg and limitedVoiceCfg.audio then
				self._videoAudioId = limitedVoiceCfg.audio
			end
		end
	end

	self._stopBgm = self._videoAudioId > 0

	if self._stopBgm then
		self:_stopMainBgm()
		TaskDispatcher.runDelay(self._stopMainBgm, self, 0.5)
	end

	if not string.nilorempty(self._videoPath) then
		self._curPlayGoodsId = goodsMo.goodsId
	end

	self:_playVideo(self._videoPath, self._mvTime, goodsMo.goodsId, finishAnimName)
end

function ClothesStoreVideoView:_getSkinViewCfgByGoodsMo(goodsMo)
	if goodsMo and goodsMo.config then
		local product = goodsMo.config.product
		local productInfo = string.splitToNumber(product, "#")
		local skinId = productInfo[2]

		return lua_character_limited.configDict[skinId]
	end
end

function ClothesStoreVideoView:_playVideo(videoPath, mvTime, goodsId, finishAnim)
	self._hasPlayFinish = false
	self._mvTime = mvTime
	self._videoFinishAnim = finishAnim

	gohelper.setActive(self._videoRoot, true)

	if not string.nilorempty(videoPath) then
		TaskDispatcher.cancelTask(self._hideVideoGo, self)

		self._videoPath = videoPath
		self._curPlayGoodsId = goodsId

		if not self._videoPlayer then
			self._videoPlayer, self._videoPlayerGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._videoGO)

			local uiVideoAdapter = MonoHelper.addNoUpdateLuaComOnceToGo(self._videoPlayerGO, FullScreenVideoAdapter)
		end

		self._videoPlayer:play(videoPath, false, self._videoStatusUpdate, self)
		TaskDispatcher.cancelTask(self._timeout, self)

		if self._mvTime and self._mvTime > 0 then
			TaskDispatcher.runDelay(self._timeout, self, self._mvTime)
		end
	else
		TaskDispatcher.runDelay(self._hideVideoGo, self, 1)
	end
end

function ClothesStoreVideoView:onClose()
	self:_stopMovie()
	TaskDispatcher.cancelTask(self._hideVideoGo, self)
end

function ClothesStoreVideoView:_onEscBtnClick()
	return
end

function ClothesStoreVideoView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying or status == VideoEnum.PlayerStatus.Error then
		TaskDispatcher.cancelTask(self._timeout, self)
		self:_playMovieFinish()

		if not string.nilorempty(self._videoFinishAnim) then
			self._viewAnim:Play(self._videoFinishAnim, 0, 0)
		end
	end

	if status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.StartedSeeking then
		if self._videoAudioId > 0 then
			AudioMgr.instance:trigger(self._videoAudioId)
		end

		self.viewCanvasGroup.alpha = 1
	end
end

function ClothesStoreVideoView:_timeout()
	self:_stopMovie()
end

function ClothesStoreVideoView:_stopMovie()
	NavigateMgr.instance:removeEscape(self.viewName)
	self:_hideVideoGo()

	if self._videoPlayer then
		self._videoPlayer:stop()

		self._videoPlayer = nil
	end

	if self._videoPlayerGO then
		gohelper.destroy(self._videoPlayerGO)

		self._videoPlayerGO = nil
	end

	TaskDispatcher.cancelTask(self._timeout, self)

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	self:_playMainBgm()
end

function ClothesStoreVideoView:_playMovieFinish()
	if self._hasPlayFinish then
		return
	end

	self._hasPlayFinish = true
	self._curPlayGoodsId = nil

	self:_hideVideoGo()
	NavigateMgr.instance:removeEscape(self.viewName)

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	self:_playMainBgm()
	ViewMgr.instance:closeView(ViewName.StoreSkinDefaultShowView)
end

function ClothesStoreVideoView:_playMainBgm()
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
	end
end

function ClothesStoreVideoView:_stopMainBgm()
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
	end
end

function ClothesStoreVideoView:_hideVideoGo()
	gohelper.setActive(self._videoRoot, false)
end

return ClothesStoreVideoView
