-- chunkname: @modules/logic/video/UnityVideoPlayer.lua

module("modules.logic.video.UnityVideoPlayer", package.seeall)
require("tolua.reflection")

local UnityVideoPlayer = class("UnityVideoPlayer", VideoPlayer)
local _videoRenderModeType, _videoRenderModeRenderTexture

local function _getVideoRenderModeRenderTexture()
	if _videoRenderModeRenderTexture then
		return _videoRenderModeRenderTexture
	end

	if not _videoRenderModeType then
		tolua.loadassembly("UnityEngine.VideoModule")

		_videoRenderModeType = tolua.findtype("UnityEngine.Video.VideoRenderMode") or System.Type.GetType("UnityEngine.Video.VideoRenderMode, UnityEngine.VideoModule") or System.Type.GetType("UnityEngine.Video.VideoRenderMode, UnityEngine")
	end

	if not _videoRenderModeType then
		logError("UnityVideoPlayer failed to reflect UnityEngine.Video.VideoRenderMode")

		return nil
	end

	_videoRenderModeRenderTexture = System.Enum.Parse(_videoRenderModeType, "RenderTexture")

	return _videoRenderModeRenderTexture
end

function UnityVideoPlayer:ctor(param)
	VideoPlayer.ctor(self, param)

	self._needRawImage = param and (param.needRawImage == nil and true or param.needRawImage) or true
end

function UnityVideoPlayer:init(go)
	if gohelper.isNil(go) then
		logError("UnityVideoPlayer init failed : go is nil")

		return
	end

	self._videoGo = go

	self:_removeAvproPlayer(go)

	self._videoPlayer = gohelper.onceAddComponent(go, typeof(UnityEngine.Video.VideoPlayer))
	self._videoPlayer.playOnAwake = false
	self._videoPlayer.timeUpdateMode = UnityEngine.Video.VideoTimeUpdateMode.GameTime

	if self._needRawImage == true then
		if not self._rtTarget then
			self._rawImage = gohelper.onceAddComponent(go, gohelper.Type_RawImage)
		else
			self._videoPlayer.renderMode = _getVideoRenderModeRenderTexture()
			self._videoPlayer.targetTexture = self._rtTarget
		end
	end

	gohelper.onceAddComponent(go, typeof(UnityEngine.CanvasRenderer)).cullTransparentMesh = false
	self._audio = gohelper.onceAddComponent(go, typeof(UnityEngine.AudioSource))
	self._videoPlayer.audioOutputMode = UnityEngine.Video.VideoAudioOutputMode.AudioSource

	self._videoPlayer:SetTargetAudioSource(0, self._audio)

	self._videoPlayerHelper = gohelper.onceAddComponent(go, typeof(ZProj.VideoPlayerHelper))

	self._videoPlayerHelper:Init()
	gohelper.setActive(self._videoGo, false)

	if go:GetComponent(typeof(UnityEngine.RectTransform)) then
		recthelper.setSize(self._videoGo.transform, self._width, self._height)
	end
end

function UnityVideoPlayer:_removeAvproPlayer(go)
	if go:GetComponent(typeof(ZProj.AvProUGUIPlayer)) then
		gohelper.removeComponent(go, typeof(ZProj.AvProUGUIPlayer))
	end

	if go:GetComponent(typeof(RenderHeads.Media.AVProVideo.DisplayUGUI)) then
		gohelper.removeComponent(go, typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	end

	if go:GetComponent(typeof(RenderHeads.Media.AVProVideo.MediaPlayer)) then
		gohelper.removeComponent(go, typeof(RenderHeads.Media.AVProVideo.MediaPlayer))
	end

	local artt = go:GetComponent(typeof(ZProj.AvProResolveToRenderTexture))

	if artt then
		self._rtTarget = artt.ExternalTexture

		gohelper.removeComponent(go, typeof(ZProj.AvProResolveToRenderTexture))

		self._needRawImage = true
	end
end

function UnityVideoPlayer:setEventListener(callback, callbackObj)
	self._videoCallback = callback
	self._videoCallbackObj = callbackObj

	self._videoPlayerHelper:SetEventListener(self._onVideoEvent, self)
end

function UnityVideoPlayer:_onVideoEvent(path, eventType, msg)
	msg = msg or VideoEnum.ErrorCode.None

	if self._videoCallback then
		self._videoCallback(self._videoCallbackObj, path, eventType, msg)
	end

	if eventType == VideoEnum.PlayerStatus.Error then
		logError("video play failed : " .. msg)

		return
	end

	if eventType == VideoEnum.PlayerStatus.ReadyToPlay then
		if self._rtTarget == nil and self._rt then
			self._rawImage.enabled = true
			self._rawImage.texture = self._rt
			self._defaultTexture = nil
		end

		return
	end

	if eventType == VideoEnum.PlayerStatus.FinishedPlaying and not self._loop then
		self._videoPlayer:Stop()

		return
	end
end

function UnityVideoPlayer:setDisplayUGUITexture(texture)
	self._defaultTexture = texture
end

function UnityVideoPlayer:play(url, loop, callback, callbackObj)
	self._videoPlayer.url = VideoPlayerMgr.instance:SwitchUrl(url)

	logNormal("UnityVideoPlayer play : " .. self._videoPlayer.url)
	self:setEventListener(callback, callbackObj)

	self._loop = not not loop
	self._videoPlayer.isLooping = self._loop

	if self._needRawImage then
		if self._rt == nil then
			self._rt = UnityEngine.RenderTexture.GetTemporary(self._width, self._height, 0, UnityEngine.RenderTextureFormat.Default)

			if self._defaultTexture then
				self._rawImage.texture = self._defaultTexture
			else
				self._rawImage.enabled = false
				self._rawImage.texture = self._rt
			end

			recthelper.setSize(self._videoGo.transform, self._width, self._height)
		end

		self._videoPlayer.targetTexture = self._rt
	end

	gohelper.setActive(self._videoGo, true)
	self._videoPlayer:Play()
end

function UnityVideoPlayer:playLoadMedia(value)
	if value ~= nil then
		self._loop = value
		self._videoPlayer.isLooping = self._loop
	end

	if self._needRawImage then
		if self._rtTarget then
			local renderTextureMode = _getVideoRenderModeRenderTexture()

			if renderTextureMode then
				self._videoPlayer.renderMode = renderTextureMode
			end

			self._videoPlayer.targetTexture = self._rtTarget
		else
			if self._rt == nil then
				self._rt = UnityEngine.RenderTexture.GetTemporary(self._width, self._height, 0, UnityEngine.RenderTextureFormat.Default)
				self._rawImage.texture = self._rt

				recthelper.setSize(self._videoGo.transform, self._width, self._height)
			end

			self._videoPlayer.targetTexture = self._rt
		end
	end

	gohelper.setActive(self._videoGo, true)
	self._videoPlayer:Play()
end

function UnityVideoPlayer:setPlaybackSpeed(speed)
	self._videoPlayer.playbackSpeed = speed
end

function UnityVideoPlayer:seek(time)
	self._videoPlayer.time = time
end

function UnityVideoPlayer:pause()
	self._videoPlayer:Pause()
end

function UnityVideoPlayer:isPaused()
	return self._videoPlayer.isPaused
end

function UnityVideoPlayer:stop()
	self._videoPlayer:Stop()

	if self._videoCallback then
		self._videoCallback = nil
		self._videoCallbackObj = nil
	end

	if self._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
	end

	gohelper.setActive(self._videoGo, false)
end

function UnityVideoPlayer:rewind(isPause)
	if not self._videoPlayer then
		return
	end

	self._videoPlayer:Stop()

	if not isPause then
		self._videoPlayer:Play()
	end
end

function UnityVideoPlayer:isPlaying()
	return self._videoPlayer.isPlaying
end

function UnityVideoPlayer:canPlay()
	return true
end

function UnityVideoPlayer:ondestroy()
	self._videoPlayer:Stop()
	self._videoPlayerHelper:Clear()
	gohelper.destroy(self._videoPlayer)
	gohelper.destroy(self._rawImage)
	gohelper.destroy(self._audio)

	if self._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
	end

	self._defaultTexture = nil

	if self.matLoader then
		self.matLoader:dispose()

		self.matLoader = nil
	end

	if self.videoMat then
		gohelper.destroy(self.videoMat)

		self.videoMat = nil
	end
end

function UnityVideoPlayer:getVideoPlayer()
	return self._videoPlayer
end

function UnityVideoPlayer:setVideoPlayRenderTexture(rt)
	if self._rt and self._rt ~= rt then
		pcall(function()
			UnityEngine.RenderTexture.ReleaseTemporary(self._rt)
		end)
	end

	self._rt = rt

	if self._needRawImage and self._rawImage then
		self._rawImage.texture = rt

		recthelper.setSize(self._videoGo.transform, self._width, self._height)
	end

	if self._videoPlayer then
		self._videoPlayer.targetTexture = rt
	end
end

function UnityVideoPlayer:setRawImageState(enable)
	if self._needRawImage then
		self._rawImage.enabled = enable
	end
end

function UnityVideoPlayer:setVideoPlayRenderMode(mode)
	self._videoPlayer.renderMode = mode
end

function UnityVideoPlayer:setScaleMode(scaleMode)
	if self._rawImage then
		self._rawImage:SetNativeSize()
		recthelper.setSize(self._videoGo.transform, self._width, self._height)

		if scaleMode == UnityEngine.ScaleMode.ScaleAndCrop then
			local videoWidth = self._videoPlayer.width
			local videoHeight = self._videoPlayer.height

			if videoWidth == 0 or videoHeight == 0 then
				return
			end

			local screenRatio = self._width / self._height
			local videoRatio = videoWidth / videoHeight

			if videoRatio < screenRatio then
				recthelper.setSize(self._videoGo.transform, self._width, self._width / videoRatio)
			else
				recthelper.setSize(self._videoGo.transform, self._height * videoRatio, self._height)
			end
		elseif scaleMode == UnityEngine.ScaleMode.ScaleToFit then
			local videoWidth = self._videoPlayer.width
			local videoHeight = self._videoPlayer.height

			if videoWidth == 0 or videoHeight == 0 then
				return
			end

			local screenRatio = self._width / self._height
			local videoRatio = videoWidth / videoHeight

			if screenRatio < videoRatio then
				recthelper.setSize(self._videoGo.transform, self._width, self._width / videoRatio)
			else
				recthelper.setSize(self._videoGo.transform, self._height * videoRatio, self._height)
			end
		elseif scaleMode == UnityEngine.ScaleMode.StretchToFill then
			recthelper.setSize(self._videoGo.transform, self._width, self._height)
		end
	end
end

function UnityVideoPlayer:loadMedia(url)
	self._videoPlayer.url = VideoPlayerMgr.instance:SwitchUrl(url)

	logNormal("UnityVideoPlayer loadMedia : " .. self._videoPlayer.url)
	self._videoPlayer:Prepare()
end

function UnityVideoPlayer:continue()
	self._videoPlayer:Play()
end

function UnityVideoPlayer:setUVRect(x, y, width, height)
	if self._rawImage then
		self._rawImage.uvRect = UnityEngine.Rect.New(x, y, width, height)
	end
end

function UnityVideoPlayer:setSkipOnDrop(skipOnDrop)
	if self._videoPlayer then
		self._videoPlayer.skipOnDrop = skipOnDrop
	end
end

local MatVector = Vector4()

function UnityVideoPlayer:resetEyeModeMat()
	if not self._rawImage then
		return
	end

	local active = EyeProtectionModeMgr.instance:getEyeModeActive()

	if not active then
		self._rawImage.material = nil

		return
	end

	if not self.videoMat then
		return self:loadMatAsset()
	end

	self._rawImage.material = self.videoMat
	MatVector.x = EyeProtectionModeMgr.instance:getFactorValue()
	MatVector.y = EyeProtectionModeMgr.instance:getIntensityValue()

	self.videoMat:SetVector(AvProMgrConfig.MatUberBrightnessId, MatVector)
end

function UnityVideoPlayer:loadMatAsset()
	if self.matLoader then
		return
	end

	self.matLoader = MultiAbLoader.New()

	self.matLoader:addPath(AvProMgrConfig.VideoMat)
	self.matLoader:startLoad(self.onMatLoadDone, self)
end

function UnityVideoPlayer:onMatLoadDone()
	local mat = self.matLoader:getFirstAssetItem():GetResource()

	self.videoMat = UnityEngine.Material.New(mat)

	self:resetEyeModeMat()
end

function UnityVideoPlayer:setVerticesDirty()
	if self._rawImage then
		self._rawImage:SetVerticesDirty()
	end
end

function UnityVideoPlayer:SetRaycast(v)
	if self._rawImage then
		self._rawImage.raycastTarget = v
	end
end

return UnityVideoPlayer
