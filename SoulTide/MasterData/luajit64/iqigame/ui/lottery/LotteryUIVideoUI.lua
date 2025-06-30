-- chunkname: @IQIGame\\UI\\Lottery\\LotteryUIVideoUI.lua

local m = {
	PlayVideoError = false,
	AutoClickDelay = -1,
	IsShow = false,
	Video2FiredStarted = false
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnMediaPlayerEvent1(mediaPlayer, eventType, errorCode)
		self:OnMediaPlayerEvent1(mediaPlayer, eventType, errorCode)
	end

	function self.DelegateOnMediaPlayerEvent2(mediaPlayer, eventType, errorCode)
		self:OnMediaPlayerEvent2(mediaPlayer, eventType, errorCode)
	end

	function self.DelegateOnClickCheckBtn()
		self:OnClickCheckBtn()
	end

	function self.DelegateOnClickSkipBtn()
		self:OnClickSkipBtn()
	end

	self.VideoScreen1:SetActive(false)
	self.VideoScreen2:SetActive(false)
	UGUIUtil.SetTextInChildren(self.SkipBtn, LotteryUIApi:GetString("SkipBtnText"))
	xpcall(function()
		local deviceInfo = LuaCodeInterface.GetDeviceInfo()

		self.DeviceInfo = "(错误已被处理，仅上报设备信息)Device: Model = " .. tostring(deviceInfo.systype) .. ", OS = " .. tostring(deviceInfo.system)
	end, function(msg)
		self.DeviceInfo = "(错误已被处理，仅上报设备信息)Device: Error " .. tostring(msg)
	end)
end

function m:OnAddListeners()
	self.CheckBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCheckBtn)
	self.SkipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSkipBtn)
end

function m:OnRemoveListeners()
	self.CheckBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCheckBtn)
	self.SkipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSkipBtn)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function m:OnRootUIOpen()
	self.Video2FiredStarted = false

	xpcall(function()
		local mediaMB = self.MediaPlayer1:GetComponent("MediaMB")

		mediaMB:AddListener(self.DelegateOnMediaPlayerEvent1)
		mediaMB:OpenVideoFromFile(LotteryUIApi:GetString("Video1"), false)

		mediaMB.Volume = SettingModule.currentMusicVolume
		mediaMB = self.MediaPlayer2:GetComponent("MediaMB")

		mediaMB:AddListener(self.DelegateOnMediaPlayerEvent2)
		mediaMB:OpenVideoFromFile(LotteryUIApi:GetString("Video2"), false)

		mediaMB.Volume = SettingModule.currentMusicVolume
	end, function(msg)
		self:OnCatchVideoException(msg)
	end)
end

function m:OnRootUIClose()
	if self.IsShow then
		self:Hide()
	end

	xpcall(function()
		local mediaMB = self.MediaPlayer1:GetComponent("MediaMB")

		mediaMB:RemoveListener(self.DelegateOnMediaPlayerEvent1)
		mediaMB:CloseVideo()

		mediaMB = self.MediaPlayer2:GetComponent("MediaMB")

		mediaMB:RemoveListener(self.DelegateOnMediaPlayerEvent2)
		mediaMB:CloseVideo()
	end, function(msg)
		logError(msg)
	end)
end

function m:Show(userData)
	self.IsShow = true
	self.Root.transform.anchoredPosition = Vector2.zero
	self.OnCloseCallback = userData.onClose
	self.BaseReward = userData.base
	self.RewardList = userData.list
	self.AutoClickDelay = userData.autoClickDelay

	self.CheckBtn:SetActive(self.AutoClickDelay < 0)
	self.VideoScreen1:SetActive(true)
	self.VideoScreen2:SetActive(false)
	self.SkipBtn:SetActive(true)

	if self.PlayVideoError then
		self:PlayComplete()

		return
	end

	self.funcPlayVideo1 = self.funcPlayVideo1 or function()
		local mediaMB = self.MediaPlayer1:GetComponent("MediaMB")

		mediaMB:Play(true)
	end
	self.funcPlayVideo1Err = self.funcPlayVideo1Err or function(msg)
		self:OnCatchVideoException(msg)
	end

	xpcall(self.funcPlayVideo1, self.funcPlayVideo1Err)

	if self.AutoClickDelay >= 0 then
		self.AutoClickDelayTimer = Timer.New(function()
			self.AutoClickDelayTimer = nil

			self:ToStepTwo()
		end, self.AutoClickDelay)

		self.AutoClickDelayTimer:Start()
	end
end

function m:Hide()
	self.IsShow = false

	if self.AutoClickDelayTimer ~= nil then
		self.AutoClickDelayTimer:Stop()

		self.AutoClickDelayTimer = nil
	end

	self.Root.transform.anchoredPosition = Vector2(0, 2000)

	self.VideoScreen1:SetActive(false)
	self.VideoScreen2:SetActive(false)
end

function m:OnCatchVideoException(msg)
	self.PlayVideoError = true

	logError(self.DeviceInfo .. "\n" .. msg)

	if self.IsShow then
		self:PlayComplete()
	end
end

function m:OnMediaPlayerEvent1(mediaPlayer, eventType, errorCode)
	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
		self:OnCatchVideoException("祈愿视频播放错误。视频序号：1，循环视频")
	end
end

function m:OnMediaPlayerEvent2(mediaPlayer, eventType, errorCode)
	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
		self:OnCatchVideoException("祈愿视频播放错误。视频序号：2，非循环视频")
	end

	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Started then
		self.Video2FiredStarted = true

		self:SwitchScreenToVideo2()
	end

	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying then
		self:PlayComplete()
	end
end

function m:PlayComplete()
	self.SkipBtn:SetActive(false)

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback(self.BaseReward, self.RewardList, false)

		self.OnCloseCallback = nil
	end
end

function m:OnClickCheckBtn()
	self:ToStepTwo()
end

function m:ToStepTwo()
	self.CheckBtn:SetActive(false)
	xpcall(function()
		local mediaMB = self.MediaPlayer1:GetComponent("MediaMB")

		mediaMB:Pause()
		mediaMB:Rewind(false)

		mediaMB = self.MediaPlayer2:GetComponent("MediaMB")

		mediaMB:Rewind(false)
		mediaMB:Play(false)
	end, function(msg)
		logError("ToStepTwo error: " .. tostring(msg))
	end)

	if self.Video2FiredStarted then
		self:SwitchScreenToVideo2()
	end
end

function m:SwitchScreenToVideo2()
	local highestQuality = 1

	for i = 1, #self.RewardList do
		local itemShowPOD = self.RewardList[i]
		local cfgItemData = CfgItemTable[itemShowPOD.cid]

		highestQuality = math.max(highestQuality, cfgItemData.Quality)
	end

	local defaultEffectCid, qualityEffectCid = LotteryUIApi:GetString("ClickSphereInVideoEffect", highestQuality)

	GameEntry.Effect:PlayUIMountPointEffect(defaultEffectCid, 50000, 0, self.EffectNode, 0)

	if qualityEffectCid ~= 0 then
		GameEntry.Effect:PlayUIMountPointEffect(qualityEffectCid, 50000, 0, self.EffectNode, 0)
	end

	self.VideoScreen1:SetActive(false)
	self.VideoScreen2:SetActive(true)
end

function m:OnClickSkipBtn()
	xpcall(function()
		local mediaMB = self.MediaPlayer1:GetComponent("MediaMB")

		mediaMB:Pause()
		mediaMB:Rewind(false)

		mediaMB = self.MediaPlayer2:GetComponent("MediaMB")

		mediaMB:Pause()
		mediaMB:Rewind(false)
	end, function(msg)
		logError("OnClickSkipBtn error: " .. tostring(msg))
	end)

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback(self.BaseReward, self.RewardList, true)

		self.OnCloseCallback = nil
	end
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
