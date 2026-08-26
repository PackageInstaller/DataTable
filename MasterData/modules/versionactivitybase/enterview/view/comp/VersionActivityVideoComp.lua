-- chunkname: @modules/versionactivitybase/enterview/view/comp/VersionActivityVideoComp.lua

module("modules.versionactivitybase.enterview.view.comp.VersionActivityVideoComp", package.seeall)

local VersionActivityVideoComp = class("VersionActivityVideoComp", UserDataDispose)

function VersionActivityVideoComp.get(videoGO, view)
	local instance = VersionActivityVideoComp.New()

	instance:init(videoGO, view)

	return instance
end

function VersionActivityVideoComp:init(videoGO, view)
	self:__onInit()

	self.videoRootGO = videoGO
	self.view = view
	self.viewContainer = view.viewContainer
end

function VersionActivityVideoComp:_initVideo()
	if not self._initFinish then
		self._initFinish = true
		self._videoPlayer, self._videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(self.videoRootGO, "videoplayer")

		self._videoPlayer:setSkipOnDrop(true)

		local uIBgSelfAdapter = self._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

		if uIBgSelfAdapter then
			uIBgSelfAdapter.enabled = false
		end
	end
end

function VersionActivityVideoComp:_destroyVideo()
	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
		self._displayUGUI = nil
		self._videoGo = nil
	end
end

function VersionActivityVideoComp:loadMedia(videoPath)
	if string.nilorempty(videoPath) then
		return
	end

	self:_initVideo()

	if self._videoPlayer then
		self._videoPlayer:loadMedia(videoPath)
	end
end

function VersionActivityVideoComp:play(videoPath, isLoop)
	self:_initVideo()
	self:_playByPath(videoPath, isLoop)
end

function VersionActivityVideoComp:resetStart()
	self:_playByPath(self._curPlayVideoPath, self._curLoop, true)
end

function VersionActivityVideoComp:_playByPath(videoPath, isLoop, reset)
	local tempLoop = isLoop == true

	if not videoPath or string.nilorempty(videoPath) or reset ~= true and self._curPlayVideoPath == videoPath and self._curLoop == tempLoop then
		return
	end

	if self._videoPlayer then
		self._curPlayVideoPath = videoPath
		self._curLoop = tempLoop

		self._videoPlayer:play(videoPath, self._curLoop, self._videoStatusUpdate, self)
	end
end

function VersionActivityVideoComp:_videoStatusUpdate(path, status, errorCode)
	logNormal(string.format("VersionActivityVideoComp:_videoStatusUpdate status:%s name:%s ", status, AvProEnum.getPlayerStatusEnumName(status)))

	if status == VideoEnum.PlayerStatus.Started and self._startCallback then
		self._startCallback(self._startCallbackTarget)
	end
end

function VersionActivityVideoComp:setStartCallback(callback, callbackTarget)
	self._startCallback = callback
	self._startCallbackTarget = callbackTarget
end

function VersionActivityVideoComp:destroy()
	self:__onDispose()
	self:_destroyVideo()

	self._startCallback = nil
	self._startCallbackTarget = nil
end

return VersionActivityVideoComp
