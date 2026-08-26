-- chunkname: @modules/logic/fight/mgr/FightVideoMgr.lua

module("modules.logic.fight.mgr.FightVideoMgr", package.seeall)

local FightVideoMgr = class("FightVideoMgr")

function FightVideoMgr:ctor()
	self._avProVideoPlayer = nil
	self._videoName = nil
	self._isPlaying = false
	self._callback = nil
	self._callbackObj = nil
	self._prefabLoader = nil
end

function FightVideoMgr:init()
	self:_checkVideCopatible()
end

function FightVideoMgr:dispose()
	self:stop()
end

function FightVideoMgr:_checkVideCopatible()
	if self._videoCopatible ~= SettingsModel.instance:getVideoCompatible() or self._unityplayer ~= SettingsModel.instance:getUseUnityVideo() then
		self:stop()

		if self._VideoPlayer then
			self._VideoPlayer = nil
		end

		if self._prefabLoader then
			self._prefabLoader:dispose()

			self._prefabLoader = nil
		end

		if self._videoRootGO then
			gohelper.destroy(self._videoRootGO)

			self._videoRootGO = nil
		end
	end
end

function FightVideoMgr:isSameVideo(videoPath)
	return videoPath == self._videoName
end

function FightVideoMgr:play(videoPath, callback, callbackObj)
	if string.nilorempty(videoPath) then
		logError("video path is nil")

		return
	end

	self._pause = false
	self._videoName = videoPath
	self._callback = callback
	self._callbackObj = callbackObj

	if self._videoRootGO then
		self:_playVideo()
	else
		self._videoCopatible = SettingsModel.instance:getVideoCompatible()
		self._unityplayer = SettingsModel.instance:getUseUnityVideo()

		if not SettingsModel.instance:isAvproVideo() then
			self:createVideoPlayer()

			return
		end

		self._prefabLoader = MultiAbLoader.New()

		self._prefabLoader:addPath(AvProMgr.instance:getFightUrl())
		self._prefabLoader:startLoad(self._onVideoPrefabLoaded, self)
	end

	FightController.instance:dispatchEvent(FightEvent.OnPlayVideo, videoPath)
end

function FightVideoMgr:_onVideoPrefabLoaded(loader)
	local uiLayer = ViewMgr.instance:getUILayer(UILayerName.PopUp)

	self._videoRootGO = gohelper.clone(loader:getFirstAssetItem():GetResource(), uiLayer, "FightVideo")

	local videoGO = gohelper.findChild(self._videoRootGO, "FightVideo")

	self._VideoPlayer = VideoPlayerMgr.instance:createVideoPlayer(videoGO)

	self._VideoPlayer:setScaleMode(UnityEngine.ScaleMode.ScaleAndCrop)
	self:_playVideo()
end

function FightVideoMgr:createVideoPlayer()
	local uiLayer = ViewMgr.instance:getUILayer(UILayerName.PopUp)

	self._videoRootGO = gohelper.create2d(uiLayer, "FightVideo")
	self._VideoPlayer = VideoPlayerMgr.instance:createVideoPlayer(self._videoRootGO)

	self._VideoPlayer:setScaleMode(UnityEngine.ScaleMode.ScaleAndCrop)
	self:_playVideo()
end

function FightVideoMgr:_playVideo()
	self:stop()

	self._isPlaying = true

	if self._VideoPlayer then
		gohelper.setActive(self._videoRootGO, true)
		self._VideoPlayer:resetEyeModeMat()
		self._VideoPlayer:loadMedia(self._videoName)
		self._VideoPlayer:play(self._videoName, false)
		self._VideoPlayer:setPlaybackSpeed(FightModel.instance:getSpeed() * Time.timeScale)

		if self._pause then
			self:pause()
		end
	end
end

function FightVideoMgr:stop()
	if self._isPlaying then
		self._pause = false
		self._isPlaying = false

		self:_stopVideo()
	end
end

function FightVideoMgr:pause()
	if self._VideoPlayer then
		gohelper.setActive(self._videoRootGO, false)
	else
		self._pause = true
	end
end

function FightVideoMgr:isPause()
	return self._pause
end

function FightVideoMgr:continue(resName)
	if self._videoName == resName and self._isPlaying then
		self._pause = false

		if self._VideoPlayer then
			gohelper.setActive(self._videoRootGO, true)
		end
	end
end

function FightVideoMgr:_stopVideo()
	if self._VideoPlayer then
		self._VideoPlayer:stop()
		gohelper.setActive(self._videoRootGO, false)
	end
end

FightVideoMgr.instance = FightVideoMgr.New()

return FightVideoMgr
