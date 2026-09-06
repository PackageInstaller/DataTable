-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/video/controller/VideoController.lua

module("logic.extensions.video.controller.VideoController", package.seeall)

local VideoController = class("VideoController", BaseController)

function VideoController:onInit()
	VideoController.super.onInit(self)
end

function VideoController:onReset()
	self._isPlayingVideo = nil
	self._finishHandler = nil
	self._playingMovie = nil
	self._finishHandlerTarget = nil

	VideoMgr.Instance:Stop()
end

function VideoController:play(movie, looping, aspectRatio, startHandler, finishHandler, target)
	if not self._curVolume then
		local fmodMgrBgmKey = "PJAQM_FMOD_MUSIC_VOLUME_KEY"

		self:setVideoVolume(checknumber(GameUtil.getLocalFloat(fmodMgrBgmKey, 0.9)))
	end

	self:stop()

	self._playingVideo = movie
	self._isPlayingVideo = true
	self._isLooping = looping
	self._startHandler = startHandler
	self._finishHandler = finishHandler
	self._finishHandlerTarget = target
	aspectRatio = aspectRatio or UnityEngine.Video.VideoAspectRatio.FitVertically

	VideoMgr.Instance:Play(movie, looping or false, aspectRatio, self._onMoviePlayStart, self._onMoviePlayFinish, self)
end

function VideoController:getCurrPlayingVideo()
	return self._playingVideo
end

function VideoController:stopVideo(videoName)
	if not self._playingVideo or self._playingVideo == videoName then
		self:stop()
	end
end

function VideoController:setVideoVolume(volume)
	self._curVolume = volume

	VideoMgr.Instance:SetAudioVolume(volume)
end

function VideoController:setVideoVolumeRate(rate)
	if not self._curVolume then
		return
	end

	VideoMgr.Instance:SetAudioVolume(self._curVolume * rate)
end

function VideoController:playByAllPath(movie, startHandler, finishHandler, target)
	self:stop()

	self._isPlayingVideo = true
	self._startHandler = startHandler
	self._finishHandler = finishHandler
	self._finishHandlerTarget = target
end

function VideoController:stop()
	VideoMgr.Instance:Stop()
	self:_onMoviePlayFinish()

	self._startHandler = nil
	self._finishHandler = nil
	self._finishHandlerTarget = nil
	self._isPlayingVideo = nil
	self._isLooping = nil
end

function VideoController:_onMoviePlayFinish()
	if self._isPlayingVideo and not self._isLooping then
		self._isPlayingVideo = nil
		self._isLooping = nil
		self._playingVideo = nil

		local handler = self._finishHandler
		local target = self._finishHandlerTarget

		self._startHandler = nil
		self._finishHandler = nil
		self._finishHandlerTarget = nil

		if handler then
			if target then
				self._finishHandler(target)
			else
				handler()
			end
		end
	end
end

function VideoController:_onMoviePlayStart()
	if self._isPlayingVideo and self._startHandler then
		if self._finishHandlerTarget then
			self._startHandler(self._finishHandlerTarget)
		else
			self._startHandler()
		end
	end
end

VideoController.instance = VideoController.New()

return VideoController
