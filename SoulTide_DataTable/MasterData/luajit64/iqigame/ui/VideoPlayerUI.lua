-- chunkname: @IQIGame\\UI\\VideoPlayerUI.lua

local VideoPlayerUI = {
	NextTextDelayElapsedTime = 0,
	CurPlayerIndex = 0,
	NextVideoDelay = 0,
	CurrentTextIndex = 0,
	StartCloseFrame = 0,
	NextTextDelay = 0,
	IsVideoPlaying = {
		false,
		false
	}
}

VideoPlayerUI = Base:Extend("VideoPlayerUI", "IQIGame.Onigao.UI.VideoPlayerUI", VideoPlayerUI)

local TextTypeHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")
local CenterText = require("IQIGame.UI.Common.CenterText")

function VideoPlayerUI:OnInit()
	function self.DelegateOnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
		self:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	end

	function self.DelegateOnClickContinueBtn()
		self:OnClickContinueBtn()
	end

	self.MediaMBs = {}
	self.MediaMBs[1] = self.MediaPlayer1:GetComponent("MediaMB")
	self.MediaMBs[2] = self.MediaPlayer2:GetComponent("MediaMB")
	self.VideoScreens = {}
	self.VideoScreens[1] = self.VideoScreen1
	self.VideoScreens[2] = self.VideoScreen2
	self.TextTypeHelper = TextTypeHelper.New()

	self.TextTypeHelper:SetTypeInterval(0.1)

	self.CenterText = CenterText.New(self.SubtitleText, self.UIController.gameObject)
	self.NextTextDelay = VideoPlayerUIApi:GetString("NextTextDelay")
	self.NextVideoDelay = VideoPlayerUIApi:GetString("NextVideoDelay")
end

function VideoPlayerUI:GetPreloadAssetPaths()
	return nil
end

function VideoPlayerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VideoPlayerUI:IsManualShowOnOpen(userData)
	return false
end

function VideoPlayerUI:GetBGM(userData)
	return nil
end

function VideoPlayerUI:OnOpen(userData)
	self:UpdateView(userData.videoCid, userData.onComplete)
end

function VideoPlayerUI:OnClose(userData)
	for i = 1, #self.MediaMBs do
		self.MediaMBs[i]:CloseVideo()
	end

	for i, v in pairs(self.IsVideoPlaying) do
		self.IsVideoPlaying[i] = false
	end

	self.LastBgmCid = nil
	self.StartCloseFrame = 0
end

function VideoPlayerUI:OnAddListeners()
	for i = 1, #self.MediaMBs do
		self.MediaMBs[i]:AddListener(self.DelegateOnMediaPlayerEvent)
	end

	self.ContinueBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickContinueBtn)
	self.ContinueBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickContinueBtn)
end

function VideoPlayerUI:OnRemoveListeners()
	for i = 1, #self.MediaMBs do
		self.MediaMBs[i]:RemoveListener(self.DelegateOnMediaPlayerEvent)
	end

	self.ContinueBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickContinueBtn)
	self.ContinueBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickContinueBtn)
end

function VideoPlayerUI:OnPause()
	return
end

function VideoPlayerUI:OnResume()
	return
end

function VideoPlayerUI:OnCover()
	return
end

function VideoPlayerUI:OnReveal()
	return
end

function VideoPlayerUI:OnRefocus(userData)
	return
end

function VideoPlayerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.StartCloseFrame ~= 0 and UnityEngine.Time.frameCount - self.StartCloseFrame > 0 then
		self:Finish()

		return
	end

	self.TextTypeHelper:Update(elapseSeconds, realElapseSeconds)

	local subtitleLength = #self.CurrentCfgData.Subtitle

	if subtitleLength > 0 and self.CurrentTextIndex > 0 and self.TextTypeHelper:IsTypeFinished() then
		if subtitleLength > self.CurrentTextIndex then
			if self.NextTextDelayElapsedTime > self.NextTextDelay then
				self.NextTextDelayElapsedTime = 0

				self:NextText()
			else
				self.NextTextDelayElapsedTime = self.NextTextDelayElapsedTime + elapseSeconds
			end
		elseif self.CurrentCfgData.IsLoop and self.CurrentTextIndex == subtitleLength then
			self.CurrentTextIndex = -1
			self.DelayAutoPlayNextTimer = Timer.New(function()
				self.DelayAutoPlayNextTimer = nil

				self:NextVideo()
			end, self.NextVideoDelay)

			self.DelayAutoPlayNextTimer:Start()
		end
	end
end

function VideoPlayerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function VideoPlayerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VideoPlayerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VideoPlayerUI:OnDestroy()
	for i = 1, #self.MediaMBs do
		self.MediaMBs[i] = nil
	end

	for i = 1, #self.VideoScreens do
		self.VideoScreens[i] = nil
	end
end

function VideoPlayerUI:UpdateView(videoCid, onComplete)
	self.OnCompleteCallback = onComplete

	local cfgSerialVideoData = CfgSerialVideoTable[videoCid]
	local mediaMB = self:GetMediaPlayer(1)

	self:PrepareMediaMB(mediaMB, cfgSerialVideoData)
	self:PlayVideo(videoCid)
end

function VideoPlayerUI:GetMediaPlayer(deltaIndexToCurrent)
	local index = self.CurPlayerIndex + deltaIndexToCurrent

	index = self:GetActualPlayerIndex(index)

	return self.MediaMBs[index], self.VideoScreens[index]
end

function VideoPlayerUI:GetActualPlayerIndex(index)
	return (index - 1) % 2 + 1
end

function VideoPlayerUI:PlayVideo(videoCid)
	if self:GetIsCurrentVideoPlaying() then
		return
	end

	self.CurPlayerIndex = self.CurPlayerIndex + 1

	self:SetIsCurrentVideoPlaying(true)

	self.CurrentCfgData = CfgSerialVideoTable[videoCid]

	self.ContinueBtn:SetActive(not self.CurrentCfgData.DisableClick)
	self.ContinueBtn2:SetActive(self.CurrentCfgData.DisableClick and self.CurrentCfgData.CanSkipWhenLock)

	if self.CurrentCfgData.BGM ~= 0 and self.LastBgmCid ~= self.CurrentCfgData.BGM then
		self.UIController:ChangeBGM(self.CurrentCfgData.BGM)

		self.LastBgmCid = self.CurrentCfgData.BGM
	end

	local mediaMB, videoScreen = self:GetMediaPlayer(0)

	mediaMB:Rewind(false)
	mediaMB:Play()
	videoScreen:SetActive(true)

	mediaMB, videoScreen = self:GetMediaPlayer(1)

	if self.CurrentCfgData.NextVideoId ~= -1 then
		local nextCfgData = CfgSerialVideoTable[self.CurrentCfgData.NextVideoId]

		self:PrepareMediaMB(mediaMB, nextCfgData)
	end

	videoScreen:SetActive(false)

	self.CurrentTextIndex = 0

	self.TextTypeHelper:ResetGameObject(self.SubtitleText)
	self:NextText()
end

function VideoPlayerUI:PrepareMediaMB(mediaMB, cfgSerialVideoData)
	mediaMB.Loop = cfgSerialVideoData.IsLoop

	local url = cfgSerialVideoData.VideoPath
	local isSuccess = false

	if cfgSerialVideoData.IsLocal then
		if string.sub(url, 1, 1) == "/" then
			url = string.sub(url, 2)
		end

		isSuccess = mediaMB:OpenVideoFromFile(url, false)
	else
		if not string.find(url, "http") then
			url = GameEntry.ProjectSetting.BuildInfo.MediaUrl .. url
		end

		isSuccess = mediaMB:OpenVideoFromHttpUrl(url, false)
	end

	mediaMB.Volume = SettingModule.currentMusicVolume

	if not isSuccess then
		self.StartCloseFrame = UnityEngine.Time.frameCount
	end
end

function VideoPlayerUI:GetIsCurrentVideoPlaying()
	return self.IsVideoPlaying[self:GetActualPlayerIndex(self.CurPlayerIndex)]
end

function VideoPlayerUI:SetIsCurrentVideoPlaying(value)
	self.IsVideoPlaying[self:GetActualPlayerIndex(self.CurPlayerIndex)] = value
end

function VideoPlayerUI:NextText()
	local subtitleLength = #self.CurrentCfgData.Subtitle

	if subtitleLength > 0 and subtitleLength > self.CurrentTextIndex then
		self.CurrentTextIndex = self.CurrentTextIndex + 1

		self.TextTypeHelper:ResetGameObject(self.SubtitleText)

		local text = self.CurrentCfgData.Subtitle[self.CurrentTextIndex]

		self.TextTypeHelper:Perform(self.SubtitleText, text)
		self.CenterText:Center(text, VideoPlayerUIApi:GetString("MaxTextWidth"))
	end
end

function VideoPlayerUI:OnClickContinueBtn()
	if self.CurrentCfgData.DisableClick and not self.CurrentCfgData.CanSkipWhenLock then
		return
	end

	if not self.TextTypeHelper:IsTypeFinished() then
		self.TextTypeHelper:StopAll()
	elseif #self.CurrentCfgData.Subtitle == 0 or self.CurrentTextIndex == -1 then
		if self.DelayAutoPlayNextTimer ~= nil then
			self.DelayAutoPlayNextTimer:Stop()

			self.DelayAutoPlayNextTimer = nil
		end

		self:NextVideo()
	else
		self.NextTextDelayElapsedTime = 0

		self:NextText()
	end
end

function VideoPlayerUI:NextVideo()
	if self.CurrentCfgData.NextVideoId == -1 then
		self:Finish()

		return
	end

	self:SetIsCurrentVideoPlaying(false)
	self:PlayVideo(self.CurrentCfgData.NextVideoId)
end

function VideoPlayerUI:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
		self.StartCloseFrame = UnityEngine.Time.frameCount

		return
	end

	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying then
		self:NextVideo()
	end
end

function VideoPlayerUI:Finish()
	UIModule.CloseSelf(self)

	if self.OnCompleteCallback ~= nil then
		self.OnCompleteCallback()

		self.OnCompleteCallback = nil
	end

	self.StartCloseFrame = 0
end

return VideoPlayerUI
