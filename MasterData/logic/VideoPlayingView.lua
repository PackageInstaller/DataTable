-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/video/view/VideoPlayingView.lua

module("logic.extensions.video.view.VideoPlayingView", package.seeall)

local VideoPlayingView = class("VideoPlayingView", ViewComponent)

function VideoPlayingView:buildUI()
	VideoPlayingView.super.buildUI(self)

	local canvas = self.mainGO:GetComponent(typeof(UnityEngine.Canvas))

	canvas.worldCamera = GlobalModel.instance.uiCamera
	self._passBtn = self:getBtn("rightTop/PassNode")

	local _adaptWidth = HardwareQuality.getAdaptWidth()

	if _adaptWidth and self._passBtn then
		local _passBtnRT = self._passBtn:GetComponent("RectTransform")

		if _passBtnRT then
			local _aPos = _passBtnRT.anchoredPosition

			if _aPos then
				_passBtnRT.anchoredPosition = Vector3.New(-_adaptWidth, _aPos.y, _aPos.z)
			end
		end
	end

	self._clickTrigger = Framework.UIClickTrigger.Get(self:getGo("ClickTrigger"))
end

function VideoPlayingView:bindEvents()
	VideoPlayingView.super.bindEvents(self)
	self._clickTrigger:AddClickListener(self._onClickSkip, self)
	self._passBtn:AddClickListener(self._onClickPass, self)
end

function VideoPlayingView:_onClickPass()
	TipsFacade.instance:openPopupWindow(lang("tip"), "确定跳过此段动画吗？", function()
		VideoFacade.instance:stop()
	end, function()
		return
	end, "确定", "取消")
end

function VideoPlayingView:unbindEvents()
	VideoPlayingView.super.unbindEvents(self)
	self._clickTrigger:RemoveClickListener()
	self._passBtn:RemoveClickListener()
end

function VideoPlayingView:onEnter()
	VideoPlayingView.super.onEnter(self)
	ViewMgr.instance:setCustomViewAttachNode("popupwindow", self.mainGO)

	if AudioPlayerEx.isInitialized then
		AudioVoicePlayer.instance:stopVoice(true, true)

		self._musicVolume = AudioPlayerEx.instance:getMusicVolume()

		AudioPlayerEx.instance:setMusicVolume(0)
	end

	local opParams = self:getOpenParam()

	self._videoName = opParams[1]
	self._isLoping = opParams[2]
	self._finishCallback = opParams[3]
	self._startCallback = opParams[4]
	self._finishCallbackObj = opParams[5]
	self._aspectRatio = opParams[6]
	self._clickSkipTime = 5

	VideoFacade.instance:setVideoVolumeRate(0.4)

	self._isPlayingCg = true

	self._passBtn.gameObject:SetActive(false)
	settimer(0, self._tickCgPlaying, self)
	VideoFacade.instance:play(self._videoName, self._isLoping, self._aspectRatio, self._onMoviePlayStart, self._onMoviePlayFinish, self)
end

function VideoPlayingView:onExit()
	ViewMgr.instance:setCustomViewAttachNode("popupwindow", nil)

	GlobalModel.instance.mainCamera.cullingMask = GlobalModel.instance.mainCamCullMask
	GlobalModel.instance.groundCamera.cullingMask = GlobalModel.instance.groundCamCullMask

	if self._musicVolume then
		AudioPlayerEx.instance:setMusicVolume(self._musicVolume)
	end

	BootstrapLauncher.instance:visibleAnim(true)

	self._clickSkipTime = nil
	self._videoName = nil

	VideoFacade.instance:setVideoVolumeRate(1)
	removetimer(self._tickCgPlaying, self)

	self._lastCgClickTime = nil
	self._isPlayingCg = nil
	self._finishCallback = nil
	self._finishCallbackObj = nil

	GlobalModel.instance:showUI(true)

	self._musicVolume = nil

	VideoPlayingView.super.onExit(self)
	HardwareQuality.initAndRestoreByUserSettings()

	if TipsFacade.popupWindowSource == self._viewPresentor.viewName and not ViewMgr.instance:isPermanent(ViewName.Popupwindow) then
		-- block empty
	end
end

function VideoPlayingView:_onMoviePlayStart()
	GlobalModel.instance:showUI(false)
	BootstrapLauncher.instance:visibleAnim(false)

	GlobalModel.instance.mainCamera.cullingMask = 0
	GlobalModel.instance.groundCamera.cullingMask = 0

	if self._startCallback then
		if self._finishCallbackObj then
			self._startCallback(self._finishCallbackObj)
		else
			self._startCallback()
		end
	end
end

function VideoPlayingView:close()
	ViewMgr.instance:close(self._viewPresentor.viewName)
end

function VideoPlayingView:_onMoviePlayFinish()
	local finishCallback = self._finishCallback
	local finishCallbackObj = self._finishCallbackObj

	self:close()

	if finishCallback then
		if finishCallbackObj then
			self._finishCallback(finishCallbackObj)
		else
			finishCallback()
		end
	end
end

function VideoPlayingView:_tickCgPlaying()
	if not self._lastCgClickTime then
		return
	end

	local unscaledTime = UnityEngine.Time.unscaledTime

	if self._passBtn.gameObject.activeSelf then
		if unscaledTime - self._lastCgClickTime >= self._clickSkipTime then
			self._passBtn.gameObject:SetActive(false)
		end
	elseif unscaledTime - self._lastCgClickTime > 0.2 and unscaledTime - self._lastCgClickTime < self._clickSkipTime then
		UnityTweens.UITweenFadeIn.StartTween(self._passBtn.gameObject, 0.4, UnityTweens.EaseType.easeOutSine)
		self._passBtn.gameObject:SetActive(true)
	end
end

function VideoPlayingView:_onClickSkip()
	if not self._isPlayingCg or self._passBtn.gameObject.activeSelf then
		return
	end

	self._lastCgClickTime = UnityEngine.Time.unscaledTime
end

return VideoPlayingView
