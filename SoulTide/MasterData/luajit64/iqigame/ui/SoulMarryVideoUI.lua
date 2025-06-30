-- chunkname: @IQIGame\\UI\\SoulMarryVideoUI.lua

local SoulMarryVideoUI = {
	playSound = 0,
	startPlay = false,
	startLoad = 2,
	currentIndex = 1,
	mediaVideoTab = {}
}

SoulMarryVideoUI = Base:Extend("SoulMarryVideoUI", "IQIGame.Onigao.UI.SoulMarryVideoUI", SoulMarryVideoUI)

require("IQIGame.UI.AVPro.AVProVideoView")

local SoulMarryVideoSelectView = require("IQIGame.UI.SoulMarry.SoulMarryVideoSelectView")

function SoulMarryVideoUI:OnInit()
	UGUIUtil.SetText(self.PanelTitle, SoulMarryVideoUIApi:GetString("PanelTitle"))

	self.sliderCom = self.Slider:GetComponent(typeof(UnityEngine.UI.Slider))
	self.marryVideoSelectView = SoulMarryVideoSelectView.New(self.SelectTime, self)

	function self.delegateBtnBack()
		self:onBtnBack()
	end

	function self.delegateBtnNextWhisper()
		self:onBtnNextWhisper()
	end

	function self.delegateOnPlayMovieLoad(data)
		self:OnPlayMovieLoad(data)
	end

	function self.delegateOnPlayMovieComplete(data)
		self:OnPlayMovieComplete(data)
	end

	function self.delegateOnLoadErrorJump()
		self:OnLoadErrorJump()
	end

	function self.delegateOnPlayStart(data)
		self:OnPlayStart(data)
	end

	function self.delegateSelectToggle(isOn)
		self:OnSelectToggle(isOn)
	end

	function self.delegateBtnShow()
		self:OnBtnShow()
	end
end

function SoulMarryVideoUI:GetPreloadAssetPaths()
	return nil
end

function SoulMarryVideoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulMarryVideoUI:IsManualShowOnOpen(userData)
	return false
end

function SoulMarryVideoUI:GetBGM(userData)
	return nil
end

function SoulMarryVideoUI:OnOpen(userData)
	UGUIUtil.SetText(self.PassTime, "")
	UGUIUtil.SetText(self.TextSubtitles, "")

	self.sliderCom.value = 0
	self.SelectToggle:GetComponent("Toggle").isOn = false

	self.marryVideoSelectView:Close()
	self:SetSelectTog(CfgDiscreteDataTable[6520072].Data[1])

	self.soulWhisperList = userData.whisperList
	self.whisperIndex = userData.index

	self.BtnNextWhisper:SetActive(#self.soulWhisperList > 1)
	self:UpdateView()
	self:ShowOrHideNode(true)
	EventDispatcher.Dispatch(EventID.StopBGM)
	EventDispatcher.Dispatch(EventID.L2DPause)
end

function SoulMarryVideoUI:OnClose(userData)
	self:ClearData()
	EventDispatcher.Dispatch(EventID.L2DResume)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function SoulMarryVideoUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateBtnBack)
	self.BtnNextWhisper:GetComponent("Button").onClick:AddListener(self.delegateBtnNextWhisper)
	self.SelectToggle:GetComponent("Toggle").onValueChanged:AddListener(self.delegateSelectToggle)
	self.BtnShow:GetComponent("Button").onClick:AddListener(self.delegateBtnShow)
end

function SoulMarryVideoUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBack)
	self.BtnNextWhisper:GetComponent("Button").onClick:RemoveListener(self.delegateBtnNextWhisper)
	self.SelectToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateSelectToggle)
	self.BtnShow:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShow)
end

function SoulMarryVideoUI:OnPause()
	return
end

function SoulMarryVideoUI:OnResume()
	return
end

function SoulMarryVideoUI:OnCover()
	return
end

function SoulMarryVideoUI:OnReveal()
	return
end

function SoulMarryVideoUI:OnRefocus(userData)
	return
end

function SoulMarryVideoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.nextAvProVideo ~= nil and self.isWait == true and self.nextAvProVideo.isMovieLoadComplete == true then
		self.isWait = false

		self:LoadCompleteAndPlay()
	end

	if self.startPlay then
		local passTime = UnityEngine.Time.time - self.startPlayTime

		UGUIUtil.SetText(self.PassTime, SoulMarryVideoUIApi:GetString("PassTime", GetFormatTime(passTime)))

		self.sliderCom.value = passTime / self.totalTime

		local showNodePass = UnityEngine.Time.time - self.startShowNodeTime

		if showNodePass > 10 then
			self:ShowOrHideNode(false)
		end
	end
end

function SoulMarryVideoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulMarryVideoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulMarryVideoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulMarryVideoUI:OnDestroy()
	self.marryVideoSelectView:Dispose()
end

function SoulMarryVideoUI:onBtnBack()
	UIModule.Close(Constant.UIControllerName.SoulMarryVideoUI)
end

function SoulMarryVideoUI:onBtnNextWhisper()
	self.whisperIndex = self.whisperIndex + 1

	if self.whisperIndex > #self.soulWhisperList then
		self.whisperIndex = 1
	end

	local data = self.soulWhisperList[self.whisperIndex]

	self:StartPlayWhisper(data)
end

function SoulMarryVideoUI:UpdateView()
	local data = self.soulWhisperList[self.whisperIndex]

	self:StartPlayWhisper(data)
end

function SoulMarryVideoUI:StartPlayWhisper(whisperData)
	self:ClearData()

	self.playWhisperData = whisperData
	self.playSound = 0
	self.currentIndex = 1
	self.paths = self.playWhisperData.Movie
	self.index = 1
	self.mediaVideoTab = {}
	self.loadCount = 0
	self.preload = 0
	self.loadIndex = 0
	self.medias = {}
	self.totalTime = 0

	for i = 1, #self.paths do
		local path = self.paths[i]

		if path ~= "" then
			if string.sub(path, 1, 1) == "/" then
				path = string.sub(path, 2)
			end

			if false then
				if not string.find(path, "http") then
					path = GameEntry.ProjectSetting.BuildInfo.MediaUrl .. path
				end
			end

			self.medias[i] = path
			self.totalTime = self.totalTime + self.playWhisperData.Time[i]
		end
	end

	self.startLoad = #self.medias > self.startLoad and self.startLoad or #self.medias

	for i = 1, self.startLoad do
		local avProVideoView = AVProVideoView.New()

		avProVideoView:LoadAVPro(self.VideoNode, i, self.medias[i])

		avProVideoView.loadComplete = self.delegateOnPlayMovieLoad
		avProVideoView.playComplete = self.delegateOnPlayMovieComplete
		avProVideoView.loadErrorJump = self.delegateOnLoadErrorJump
		avProVideoView.playStarted = self.delegateOnPlayStart
		self.mediaVideoTab[i] = avProVideoView
	end

	UGUIUtil.SetText(self.PanelTitle, self.playWhisperData.Title)
end

function SoulMarryVideoUI:OnPlayMovieLoad(data)
	self.preload = self.preload + 1

	if self.preload == self.startLoad then
		self.currentIndex = 1

		self:PlayerVideo()
	end
end

function SoulMarryVideoUI:PlayerVideo()
	self.loadIndex = self.loadIndex + 1

	local nextLoad = self.startLoad + self.loadIndex

	if nextLoad <= #self.medias then
		local avProVideoView = AVProVideoView.New()

		avProVideoView:LoadAVPro(self.VideoNode, nextLoad, self.medias[nextLoad])

		avProVideoView.loadComplete = self.delegateOnPlayMovieLoad
		avProVideoView.playComplete = self.delegateOnPlayMovieComplete
		avProVideoView.loadErrorJump = self.delegateOnLoadErrorJump
		avProVideoView.playStarted = self.delegateOnPlayStart
		self.mediaVideoTab[nextLoad] = avProVideoView
	end

	self.nextAvProVideo = self.mediaVideoTab[self.currentIndex]

	if self.nextAvProVideo.isMovieLoadComplete == true then
		self.isWait = false

		self:LoadCompleteAndPlay()
	else
		self.isWait = true
	end
end

function SoulMarryVideoUI:LoadCompleteAndPlay()
	if self.currentAvProVideo then
		self.waitCloseAvProVideo = self.currentAvProVideo
	end

	self.currentAvProVideo = self.nextAvProVideo

	self.currentAvProVideo:PlayVideo(true)

	do
		local timeCD = self.playWhisperData.Time[self.currentIndex]

		if self.playMovieTimer then
			self.playMovieTimer:Stop()

			self.playMovieTimer = nil
		end

		self.playMovieTimer = Timer.New(function()
			self:OnPlayMovieComplete({
				index = self.currentIndex
			})
		end, timeCD)

		self.playMovieTimer:Start()
	end

	if false then
		self.currentAvProVideo:PlayVideo(false)
	end

	if self.startPlay == false then
		self.startPlay = true
		self.startPlayTime = UnityEngine.Time.time
		self.startShowNodeTime = UnityEngine.Time.time
		self.cvIndex = 0

		self:PlaySound()
		self:PlaySubtitles()
	end
end

function SoulMarryVideoUI:OnPlayStart(data)
	if self.waitCloseAvProVideo ~= nil then
		self.waitCloseAvProVideo:CloseVideo()
	end
end

function SoulMarryVideoUI:OnPlayMovieComplete(data)
	self.currentIndex = data.index + 1

	if self.currentIndex <= #self.medias then
		self:PlayerVideo()
	else
		self:StartPlayWhisper(self.playWhisperData)
	end
end

function SoulMarryVideoUI:PlaySound()
	if self.playWhisperData.BGM > 0 then
		self.UIController:ChangeBGM(self.playWhisperData.BGM)
	end

	if self.playWhisperData.SoundID > 0 then
		self.playSound = GameEntry.Sound:PlaySound(self.playWhisperData.SoundID, Constant.SoundGroup.CHARACTER)
	end
end

function SoulMarryVideoUI:PlaySubtitles()
	self.cvIndex = self.cvIndex + 1

	if self.playCVTimer then
		self.playCVTimer:Stop()

		self.playCVTimer = nil
	end

	if self.cvIndex <= #self.playWhisperData.Subtitle then
		local cvID = self.playWhisperData.Subtitle[self.cvIndex]
		local cfgCVData = CfgCVTable[cvID]

		self.playCVTimer = Timer.New(function()
			self:PlaySubtitles()
		end, cfgCVData.TextTime)

		self.playCVTimer:Start()

		local str = string.gsub(cfgCVData.Text, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

		UGUIUtil.SetText(self.TextSubtitles, str)
	else
		UGUIUtil.SetText(self.TextSubtitles, "")
	end
end

function SoulMarryVideoUI:OnSelectToggle(isOn)
	if isOn then
		self.marryVideoSelectView:Open()
	else
		self.marryVideoSelectView:Close()
	end
end

function SoulMarryVideoUI:SetSelectTog(num)
	self.exitTimeCD = num
	self.SelectToggle:GetComponent("ToggleHelperComponent").text = SoulMarryVideoUIApi:GetString("SelectTimeLabel", num)

	self.marryVideoSelectView:Close()

	self.SelectToggle:GetComponent("Toggle").isOn = false

	if self.exitTimer then
		self.exitTimer:Stop()

		self.exitTimer = nil
	end

	if self.exitTimeCD > 0 then
		self.exitTimer = Timer.New(function()
			LuaCodeInterface.QuitGame()
		end, self.exitTimeCD * 60)

		self.exitTimer:Start()
	end
end

function SoulMarryVideoUI:ClearData()
	self.startPlay = false

	if self.playMovieTimer then
		self.playMovieTimer:Stop()
	end

	self.playMovieTimer = nil

	if self.playCVTimer then
		self.playCVTimer:Stop()
	end

	self.playCVTimer = nil

	if self.exitTimer then
		self.exitTimer:Stop()
	end

	self.exitTimer = nil

	if self.playSound > 0 then
		GameEntry.Sound:StopSound(self.playSound)
	end

	self.playSound = 0
	self.playMovieTimer = nil

	if self.currentAvProVideo then
		self.currentAvProVideo:DisPose()

		self.currentAvProVideo = nil
	end

	if self.nextAvProVideo then
		self.nextAvProVideo:DisPose()

		self.nextAvProVideo = nil
	end

	if self.waitCloseAvProVideo then
		self.waitCloseAvProVideo:DisPose()

		self.waitCloseAvProVideo = nil
	end

	for i, v in pairs(self.mediaVideoTab) do
		v:DisPose()
	end

	for i = 0, self.VideoNode.transform.childCount - 1 do
		local obj = self.VideoNode.transform:GetChild(0).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	self.sliderCom.value = 0

	UGUIUtil.SetText(self.TextSubtitles, "")
end

function SoulMarryVideoUI:OnBtnShow()
	if self.startPlay then
		self.startShowNodeTime = UnityEngine.Time.time

		self:ShowOrHideNode(true)
	end
end

function SoulMarryVideoUI:ShowOrHideNode(top)
	self.PlayStateNode:SetActive(top)
	self.PercentNode:SetActive(top)
	self.TitleNode:SetActive(top)
end

function SoulMarryVideoUI:OnLoadErrorJump()
	return
end

return SoulMarryVideoUI
