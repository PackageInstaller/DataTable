-- chunkname: @modules/logic/video/AvProPlayer.lua

module("modules.logic.video.AvProPlayer", package.seeall)

local AvProPlayer = class("AvProPlayer", VideoPlayer)

AvProPlayer.DEFAULT_WIDTH = 2592
AvProPlayer.DEFAULT_HEIGHT = 1080

function AvProPlayer:ctor(param)
	VideoPlayer.ctor(self, param)
end

function AvProPlayer:init(go)
	if gohelper.isNil(go) then
		logError("AvProPlayer init failed : go is nil")

		return
	end

	self._videoGo = go

	gohelper.setActive(self._videoGo, false)

	if self._width == nil or self._height == nil then
		local rectTran = self._videoGo:GetComponent(gohelper.Type_RectTransform)

		if rectTran ~= nil then
			self._width = recthelper.getWidth(rectTran)
			self._height = recthelper.getHeight(rectTran)
		else
			self._width = VideoPlayerMgr.DEFAULT_HEIGHT
			self._height = VideoPlayerMgr.DEFAULT_WIDTH
		end
	end

	local videoPlayer = gohelper.onceAddComponent(go, VideoPlayerMgr.Type_AvProUGUIPlayer)

	self._mediaPlayer = gohelper.onceAddComponent(go, typeof(RenderHeads.Media.AVProVideo.MediaPlayer))
	self._videoPlayer = videoPlayer

	local solverTexture = go:GetComponent(typeof(ZProj.AvProResolveToRenderTexture))

	if solverTexture then
		gohelper.removeComponent(go, VideoPlayerMgr.Type_DisplayUGUI)

		self._solverTexture = solverTexture
		self._solverTexture.MediaPlayer = self._mediaPlayer

		if self._solverTexture.ExternalTexture then
			self._rt = self._solverTexture.ExternalTexture
		else
			local rt = UnityEngine.RenderTexture.GetTemporary(self._width, self._height, 0, UnityEngine.RenderTextureFormat.ARGB32)

			rt.wrapMode = UnityEngine.TextureWrapMode.Repeat
			self._rt = rt
			self._solverTexture.ExternalTexture = rt
		end
	else
		self._displayUGUI = gohelper.onceAddComponent(go, VideoPlayerMgr.Type_DisplayUGUI)
		self._srcMat = self._displayUGUI.material

		recthelper.setSize(self._videoGo.transform, self._width, self._height)
	end
end

function AvProPlayer:play(url, loop, callback, callbackObj)
	url = VideoPlayerMgr.instance:SwitchUrl(url)
	self._loop = loop or false
	self._url = url

	if callback ~= nil and callbackObj ~= nil then
		self._callback = callback
		self._callbackObj = callbackObj
	end

	self._videoPlayer:SetEventListener(self._onVideoEvent, self)
	logNormal("UnityVideoPlayer play : " .. self._url)
	gohelper.setActive(self._videoGo, true)

	if self._solverTexture then
		self._mediaPlayer.Loop = loop

		self._mediaPlayer:OpenMedia(RenderHeads.Media.AVProVideo.MediaPathType.AbsolutePathOrURL, url, false)
		self._mediaPlayer:Play()
	else
		self._videoPlayer:Play(self._displayUGUI, url, self._loop)
	end
end

function AvProPlayer:playLoadMedia(value)
	gohelper.setActive(self._videoGo, true)

	if self._solverTexture then
		self._mediaPlayer:OpenMedia(value)
	else
		self._videoPlayer:Play(self._displayUGUI, value)
	end
end

function AvProPlayer:_onVideoEvent(path, status, errorCode)
	status = VideoPlayerMgr.instance:getStateCode(status)

	if self._callback then
		self._callback(self._callbackObj, path, status, errorCode)
	end
end

function AvProPlayer:setPlaybackSpeed(speed)
	self._mediaPlayer.PlaybackRate = speed
end

function AvProPlayer:loadMedia(videoPath)
	videoPath = self.getVideoAbsolutePath(videoPath)
	self._url = videoPath

	self._videoPlayer:LoadMedia(videoPath)
end

function AvProPlayer:closeMedia()
	self._mediaPlayer:CloseMedia()
end

function AvProPlayer:setEventListener(callback, callbackObj)
	self._videoPlayer:SetEventListener(callback, callbackObj)
end

function AvProPlayer:setScaleMode(scaleMode)
	self._displayUGUI.ScaleMode = scaleMode
end

function AvProPlayer:seek(time)
	self._videoPlayer:Seek(time)
end

function AvProPlayer:getTimeRange(startTime, duration, curTime)
	return self._videoPlayer:GetTimeRange(startTime, duration, curTime)
end

function AvProPlayer:pause()
	self._videoPlayer:Pause()
end

function AvProPlayer:continue()
	self._videoPlayer:Continue()
end

function AvProPlayer:stop()
	self._videoPlayer:Stop()
	gohelper.setActive(self._videoGo, false)
end

function AvProPlayer:rewind(isPause)
	self._videoPlayer:Rewind(isPause)
end

function AvProPlayer:clear()
	self._videoPlayer:Clear()
end

function AvProPlayer:isPlaying()
	return self._videoPlayer:IsPlaying()
end

function AvProPlayer:isPaused()
	return self._videoPlayer:IsPaused()
end

function AvProPlayer:isFinished()
	return self._videoPlayer:IsFinished()
end

function AvProPlayer:canPlay()
	return self._videoPlayer:CanPlay()
end

function AvProPlayer:setUVRect(x, y, width, height)
	if self._displayUGUI then
		self._displayUGUI.uvRect = UnityEngine.Rect.New(x, y, width, height)
	end
end

function AvProPlayer:setVerticesDirty()
	if self._displayUGUI then
		self._displayUGUI:SetVerticesDirty()
	end
end

function AvProPlayer:setDisplayUGUITexture(texture)
	if self._displayUGUI then
		self._displayUGUI.DefaultTexture = texture
	end
end

function AvProPlayer:setNoDefaultDisplayState(enable)
	if self._displayUGUI then
		self._displayUGUI.NoDefaultDisplay = enable
	end
end

function AvProPlayer:setUGUIState(enable)
	if self._displayUGUI then
		self._displayUGUI.enabled = enable
	end
end

function AvProPlayer:setVerticesDirty()
	if self._displayUGUI then
		self._displayUGUI:SetVerticesDirty()
	end
end

function AvProPlayer:setScaleMode(scaleMode)
	if self._displayUGUI then
		self._displayUGUI.ScaleMode = scaleMode
	end
end

function AvProPlayer:loadMedia(url)
	url = VideoPlayerMgr.instance:SwitchUrl(url)
	self._url = url

	if self._solverTexture then
		self._mediaPlayer:CloseMedia()

		self._mediaPlayer.Loop = self._loop

		self._mediaPlayer:OpenMedia(RenderHeads.Media.AVProVideo.MediaPathType.AbsolutePathOrURL, url, false)
	else
		self._videoPlayer:LoadMedia(url)
	end
end

local MatVector = Vector4()

function AvProPlayer:resetEyeModeMat()
	if not self._displayUGUI then
		return
	end

	local active = EyeProtectionModeMgr.instance:getEyeModeActive()

	if not active then
		self._displayUGUI.material = nil

		return
	end

	self._displayUGUI.material = self._srcMat
	MatVector.x = EyeProtectionModeMgr.instance:getFactorValue()
	MatVector.y = EyeProtectionModeMgr.instance:getIntensityValue()

	self._srcMat:SetVector(AvProMgrConfig.MatUberBrightnessId, MatVector)
end

function AvProPlayer:ondestroy()
	self._videoPlayer:Clear()

	self._callback = nil
	self._callbackObj = nil

	if self._videoPlayer then
		gohelper.destroy(self._videoPlayer)
	end

	if self._displayUGUI then
		gohelper.destroy(self._displayUGUI)
	end

	if self._solverTexture then
		gohelper.destroy(self._solverTexture)
	end

	if self._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
	end
end

function AvProPlayer:setSkipOnDrop(skipOnDrop)
	return
end

return AvProPlayer
