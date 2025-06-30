-- chunkname: @IQIGame\\UI\\Main\\MainOathAvBGView.lua

local m = {
	playSound = 0,
	currentPlay = 0,
	isStop = false,
	loadIndex = 0,
	Movies = {}
}

require("IQIGame.UI.AVPro.AVProVideoView")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnWhisperLabel, MainUIApi:GetString("BtnWhisperLabel"))

	function self.delegateOnPlayMovieLoad(data)
		self:OnPlayMovieLoad(data)
	end

	function self.delegateOnPlayMovieComplete(data)
		self:OnPlayMovieComplete(data)
	end

	function self.delegateBtnWhisper()
		self:OnBtnWhisper()
	end

	function self.delegateStopBGM()
		self:OnStopBGM()
	end

	function self.delegateRestoreBGM()
		self:OnRestoreBGM()
	end
end

function m:AddListener()
	self.BtnWhisper:GetComponent("Button").onClick:AddListener(self.delegateBtnWhisper)
	EventDispatcher.AddEventListener(EventID.StopMainCityCV, self.delegateStopBGM)
	EventDispatcher.AddEventListener(EventID.RestoreMainCityCV, self.delegateRestoreBGM)
end

function m:RemoveListener()
	self.BtnWhisper:GetComponent("Button").onClick:RemoveListener(self.delegateBtnWhisper)
	EventDispatcher.RemoveEventListener(EventID.StopMainCityCV, self.delegateStopBGM)
	EventDispatcher.RemoveEventListener(EventID.RestoreMainCityCV, self.delegateRestoreBGM)
end

function m:LoadMovie()
	local len = #self.videoPath
	local pathIndex = self.loadIndex % len

	if pathIndex == 0 then
		pathIndex = len
	end

	local avProVideoView = AVProVideoView.New()

	avProVideoView:LoadAVPro(self.VideoNode, self.loadIndex, self.videoPath[pathIndex])

	avProVideoView.loadComplete = self.delegateOnPlayMovieLoad
	avProVideoView.playComplete = self.delegateOnPlayMovieComplete
	self.Movies[self.loadIndex] = avProVideoView
end

function m:OnPlayMovieLoad(data)
	if data.index == 1 then
		self.currentPlay = data.index

		if #self.videoPath == 1 then
			self.Movies[data.index]:PlayVideo(true)
		else
			self.Movies[data.index]:PlayVideo(false)
		end

		self.playCVTimer = Timer.New(function()
			self:PlaySubtitles()
		end, 40, -1)

		self.playCVTimer:Start()
		self:PlaySubtitles()
	else
		self.Movies[data.index]:Pause()

		if self.currentPlay == data.index then
			self.Movies[self.currentPlay]:PlayVideo(false)
		end
	end

	if #self.videoPath > 1 then
		self:CheckLoad()
	end
end

function m:OnPlayMovieComplete(data)
	self.currentPlay = data.index + 1

	self.Movies[self.currentPlay]:PlayVideo(false)
	self.Movies[data.index]:CloseVideo()

	self.Movies[data.index] = nil

	self:CheckLoad()
end

function m:CheckLoad()
	if self.currentPlay == self.loadIndex then
		self.loadIndex = self.loadIndex + 1

		self:LoadMovie()
	end
end

function m:PlaySubtitles()
	if self.isStop then
		return
	end

	local randomIndex = math.random(1, #self.cfgSoulMarry.MainUICV)
	local cvID = self.cfgSoulMarry.MainUICV[randomIndex]
	local cfgCVData = CfgCVTable[cvID]

	self.playCVEndTimer = Timer.New(function()
		UGUIUtil.SetText(self.TextSubtitles, "")
		self.Talk:SetActive(false)
		self.playCVEndTimer:Stop()

		self.playCVEndTimer = nil
	end, cfgCVData.TextTime)

	self.playCVEndTimer:Start()
	self.Talk:SetActive(true)
	UGUIUtil.SetText(self.TextSubtitles, cfgCVData.Text)

	if cfgCVData.SoundID > 0 then
		self.playSound = GameEntry.Sound:PlaySound(cfgCVData.SoundID, Constant.SoundGroup.CHARACTER)
	end

	self.Talk.transform.anchoredPosition = MainUIApi:GetString("TalkPos", self.cfgSoulMarry.Id)
end

function m:Open()
	self.isStop = false

	self:AddListener()
	UGUIUtil.SetText(self.TextSubtitles, "")
	self.View:SetActive(true)

	self.cfgSoulMarry = GirlModule.GetSoulOathData(SoulModule.curSoulData.soulCid)
	self.loadIndex = 1
	self.currentPlay = 0
	self.videoPath = {}

	for i = 1, #self.cfgSoulMarry.MainUIMovie do
		local path = self.cfgSoulMarry.MainUIMovie[i]

		if string.sub(path, 1, 1) == "/" then
			path = string.sub(path, 2)
		end

		table.insert(self.videoPath, path)
	end

	self:LoadMovie()

	self.soulWhisperList, self.soulOpenWhisperList = GirlModule.GetSoulWhisperListData(SoulModule.curSoulData.soulCid)

	self.BtnWhisper:SetActive(#self.soulOpenWhisperList > 0)
end

function m:OnBtnWhisper()
	if #self.soulOpenWhisperList > 0 then
		UIModule.Open(Constant.UIControllerName.SoulMarryVideoUI, Constant.UILayer.UI, {
			index = 1,
			whisperList = self.soulOpenWhisperList
		})
	end
end

function m:OnStopBGM()
	self.isStop = true

	if self.Movies[self.currentPlay] then
		self.Movies[self.currentPlay]:Pause()
	end

	if self.playSound > 0 then
		GameEntry.Sound:StopSound(self.playSound)
	end

	self.playSound = 0
end

function m:OnRestoreBGM()
	self.isStop = false

	if self.Movies[self.currentPlay] then
		if #self.videoPath == 1 then
			self.Movies[self.currentPlay]:PlayVideo(true)
		else
			self.Movies[self.currentPlay]:PlayVideo(false)
		end
	end
end

function m:Close()
	self:RemoveListener()
	self.View:SetActive(false)

	for i, v in pairs(self.Movies) do
		v:DisPose()
	end

	if self.playSound > 0 then
		GameEntry.Sound:StopSound(self.playSound)
	end

	self.playSound = 0

	if self.playCVTimer then
		self.playCVTimer:Stop()
	end

	self.playCVTimer = nil

	if self.playCVEndTimer then
		self.playCVEndTimer:Stop()
	end

	self.playCVEndTimer = nil
end

function m:Dispose()
	self:Close()

	for i, v in pairs(self.Movies) do
		v:DisPose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
