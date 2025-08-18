-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\SequenceFramePlayer.lua

local UISequenceFramePlayer = typeof(Framework.UI.UISequenceFramePlayer)
local UI2DAnimationPlayer = typeof(Framework.UI.UI2DAnimationPlayer)
local UIVideoPlayer = typeof(Framework.UI.UIVideoPlayer)
local UIRealtimeStagePlayer = typeof(Framework.UI.UIRealtimeStagePlayer)
local strClassName = "SequenceFramePlayer"
local SequenceFramePlayer = Class(strClassName, UIControls.Window)

function SequenceFramePlayer:ctor(...)
	self:initUI()
end

function SequenceFramePlayer:initUI(...)
	self.sequencePanel = UIControls.Panel(self, "SFPlayer")

	local imageGO = self.sequencePanel:getGameObject()

	if imageGO then
		self.sequencePlayer = imageGO:GetComponent(UISequenceFramePlayer)
	end

	self.panelFunc = UIControls.Panel(self, "FuncPanel")
	self.btnEnd = UIControls.Button(self, "FuncPanel/BtnSkip")

	self.btnEnd:addEventClick(self.onBtnEnd)

	self.animationPanel = UIControls.Panel(self, "AniPanel")
	self.videoPanel = UIControls.Panel(self, "VideoPlayer")

	local videoGO = self.videoPanel:getGameObject()

	if videoGO then
		self.videoPlayer = videoGO:GetComponent(UIVideoPlayer)
	end

	self.videoBgPanel = UIControls.Panel(self, "VideoPlayer/Block")
	self.realtimeStagePanel = UIControls.Panel(self, "RealtimeStagePlayer")

	local realtimeGO = self.realtimeStagePanel:getGameObject()

	if realtimeGO then
		self.realtimePlayer = realtimeGO:GetComponent(UIRealtimeStagePlayer)
	end

	self.panelList = {
		self.sequencePanel,
		self.animationPanel,
		self.videoPanel,
		self.realtimeStagePanel
	}
end

function SequenceFramePlayer:_openPanelByIndex(index)
	for i, panel in ipairs(self.panelList) do
		panel:setVisible(i == index, true)
	end
end

function SequenceFramePlayer:setSequenceFrame(folderPath, frameCount, endCallback)
	self:_openPanelByIndex(1)

	if self.sequencePlayer then
		self.sequencePlayer:SetImages(folderPath, frameCount, endCallback)
		self.sequencePlayer:Play()
	end
end

function SequenceFramePlayer:playSequenceFrame()
	if self.sequencePlayer then
		self.sequencePlayer:Play()
	end
end

function SequenceFramePlayer:testCase(...)
	self.sequencePlayer:TestCase()
end

local AnimationCell = Class("AnimationCell", UIControls.Child)

function AnimationCell:ctor(...)
	local cellGO = self:getController().gameObject

	if cellGO then
		self.csharpPlayer = cellGO:GetComponent(UI2DAnimationPlayer)
	end
end

function SequenceFramePlayer:set2DAnimation(url, playOnLoaded)
	self:_openPanelByIndex(2)

	self.animation2D = AnimationCell(self, "AniPanel", url, 0, 0, false)

	self.animation2D.csharpPlayer:SetEndCallback(Slot(self.stop2DAnimation, self))

	if playOnLoaded then
		self.animation2D:setVisible(true)
	end
end

function SequenceFramePlayer:play2DAnimation(...)
	if self.animation2D then
		self.animation2D:setVisible(true)
	end
end

function SequenceFramePlayer:stop2DAnimation(...)
	self.animationPanel:setVisible(false)

	if self.animation2D then
		self.animation2D:setVisible(false)
		self.animation2D:destroy()

		self.animation2D = nil
	end
end

function SequenceFramePlayer:pause2DAnimation(...)
	if self.animation2D and self.animation2D.csharpPlayer then
		self.animation2D.csharpPlayer:Pause2DAnimation()
	end
end

function SequenceFramePlayer:resume2DAnimation(...)
	if self.animation2D and self.animation2D.csharpPlayer then
		self.animation2D.csharpPlayer:Resume2DAnimation()
	end
end

function SequenceFramePlayer:playVideo(url, mirror, endCallback, canSkip, muteBGM, needBg, endTime)
	self.url = url

	if canSkip then
		self.panelFunc:setVisible(true)
	else
		self.panelFunc:setVisible(false)
	end

	if needBg then
		self.videoBgPanel:setVisible(true)
	else
		self.videoBgPanel:setVisible(false)
	end

	self:_openPanelByIndex(3)

	if self.videoPlayer then
		if muteBGM then
			CueManager.stopBGM()

			self.bgmIsMute = true
		end

		self.videoCallback = endCallback

		self.videoPlayer:MirrorVideo(mirror)
		self.videoPlayer:PlayVideo(url, Slot(self._videoEndCallback, self))

		if endTime then
			if self.delayClose then
				self.delayClose:Stop()

				self.delayClose = nil
			end

			self.delayClose = Timer.New(Slot(self._videoEndCallback, self), endTime, 1)

			self.delayClose:Restart()
		end
	end
end

function SequenceFramePlayer:onBtnEnd()
	if self.urlList then
		self:checkNextVideo()
	else
		self:stopVideo()
		self:_videoEndCallback()
	end

	if self.url and CurAvatar then
		CurAvatar:sendAvgAnalyticsData(Const.OSS_TYPE_SKIP_MOVIE, self.url)
	end
end

function SequenceFramePlayer:stopVideo(...)
	self.videoPanel:setVisible(false)
	self.panelFunc:setVisible(false)

	if self.videoPlayer then
		self.videoPlayer:StopVideo()
	end
end

function SequenceFramePlayer:pauseVideo(...)
	if self.videoPlayer then
		self.videoPlayer:PauseVideo()
	end
end

function SequenceFramePlayer:resumeVideo(...)
	if self.videoPlayer then
		self.videoPlayer:ResumeVideo()
	end
end

function SequenceFramePlayer:_videoEndCallback()
	self.url = nil
	self.urlList = nil

	if self.bgmIsMute then
		CueManager._revertBGM()

		self.bgmIsMute = nil
	end

	if self.videoCallback then
		self.videoCallback()

		self.videoCallback = nil
	end

	self.videoPanel:setVisible(false)
	self.panelFunc:setVisible(false)
end

function SequenceFramePlayer:playVideoToCamera(url, endCallback)
	self:_openPanelByIndex(3)

	if self.videoPlayer then
		self.videoPlayer:PlayVideoToCam(url, endCallback)
	end
end

function SequenceFramePlayer:playVideoToMaterial(url, endCallback)
	self:_openPanelByIndex(3)

	if self.videoPlayer then
		self.videoPlayer:PlayVideoToMaterial(url, endCallback)
	end
end

function SequenceFramePlayer:playVideoWithClip(url, endCallback)
	self:_openPanelByIndex(3)

	if self.videoPlayer then
		self.videoPlayer:PlayVideoWithVideoClip(url, endCallback)
	end
end

function SequenceFramePlayer:playVideoList(urlList, mirror, endCallback, canSkip, muteBGM, needBg)
	if not urlList or #urlList < 1 then
		return
	end

	if canSkip then
		self.panelFunc:setVisible(true)
	else
		self.panelFunc:setVisible(false)
	end

	if needBg then
		self.videoBgPanel:setVisible(true)
	else
		self.videoBgPanel:setVisible(false)
	end

	self:_openPanelByIndex(3)

	self.urlList = urlList
	self.curPlayIdx = 1

	if self.videoPlayer then
		if muteBGM then
			CueManager.stopBGM()

			self.bgmIsMute = true
		end

		self.videoCallback = endCallback

		self.videoPlayer:MirrorVideo(mirror)
		self:checkNextVideo()
	end
end

function SequenceFramePlayer:checkNextVideo()
	if self.curPlayIdx and self.urlList and #self.urlList >= self.curPlayIdx then
		self.videoPlayer:PlayVideo(self.urlList[self.curPlayIdx], Slot(self.playNextVideo, self))

		self.curPlayIdx = self.curPlayIdx + 1
	else
		self:stopVideo()
		self:_videoEndCallback()
	end
end

function SequenceFramePlayer:playNextVideo(...)
	self.videoPlayer:StopVideo()
	coroutine.start(self._nextFramePlay, self)
end

function SequenceFramePlayer:_nextFramePlay()
	coroutine.step()
	self:checkNextVideo()
end

function SequenceFramePlayer:playRealtimeStage(url, actorModelAux, mirror)
	self:_openPanelByIndex(4)

	if self.realtimePlayer then
		self.realtimePlayer:MirrorRealtimeStage(mirror)
		self.realtimePlayer:PlayRealtimeStage(url, actorModelAux, Slot(self._realtimeStageEndCallback, self))
	end
end

function SequenceFramePlayer:stopRealtimeStage(...)
	self.realtimeStagePanel:setVisible(false)

	if self.realtimePlayer then
		self.realtimePlayer:StopRealtimeStage()
	end
end

function SequenceFramePlayer:pauseRealtimeStage(...)
	if self.realtimePlayer then
		self.realtimePlayer:PauseRealtimeStage()
	end
end

function SequenceFramePlayer:resumeRealtimeStage(...)
	if self.realtimePlayer then
		self.realtimePlayer:ResumeRealtimeStage()
	end
end

function SequenceFramePlayer:_realtimeStageEndCallback(...)
	self.realtimeStagePanel:setVisible(false)
end

function SequenceFramePlayer:pauseCurrentMedia(...)
	if self.videoPanel:getVisible() then
		self:pauseVideo()
	end

	if self.realtimeStagePanel:getVisible() then
		self:pauseRealtimeStage()
	end

	if self.animationPanel:getVisible() then
		self:pause2DAnimation()
	end
end

function SequenceFramePlayer:resumeCurrentMedia(...)
	if self.videoPanel:getVisible() then
		self:resumeVideo()
	end

	if self.realtimeStagePanel:getVisible() then
		self:resumeRealtimeStage()
	end

	if self.animationPanel:getVisible() then
		self:resume2DAnimation()
	end
end

function SequenceFramePlayer:onClose(...)
	if self.sequencePlayer then
		self.sequencePlayer:Stop()
		self.sequencePlayer:ReleaseResources()
	end

	self:setVisible(false)
end

return SequenceFramePlayer
