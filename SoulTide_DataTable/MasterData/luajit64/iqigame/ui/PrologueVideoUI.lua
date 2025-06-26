-- chunkname: @IQIGame\\UI\\PrologueVideoUI.lua

local PrologueVideoUI = Base:Extend("PrologueVideoUI", "IQIGame.Onigao.UI.PrologueVideoUI", {
	startLoad = 2,
	currentIndex = 1
})

require("IQIGame.UI.AVPro.AVProVideoView")

function PrologueVideoUI:OnInit()
	UGUIUtil.SetText(self.TextBtnBack, PrologueVideoUIApi:GetString("TextBtnBack"))
	UGUIUtil.SetText(self.TextBtnJump, PrologueVideoUIApi:GetString("TextBtnJump"))

	function self.delegateClickBtnBack()
		self:OnBtnBack()
	end

	function self.delegateClickBtnJump()
		self:OnBtnJump()
	end

	function self.delegateOnPlayMovieLoad(data)
		self:OnPlayMovieLoad(data)
	end

	function self.delegateOnPlayMovieComplete(data)
		self:OnPlayMovieComplete(data)
	end

	function self.delegateOnLoadAVProComplete(data)
		self:OnLoadAVProComplete(data)
	end

	function self.delegateOnLoadErrorJump()
		self:OnLoadErrorJump()
	end

	function self.delegateOnPlayStart(data)
		self:OnPlayStart(data)
	end

	self.tweenAlpha = self.Text:GetComponent("TweenAlpha")
	self.tweenDuration = self.tweenAlpha.duration
	self.tweenForm = self.tweenAlpha.from
	self.tweenTo = self.tweenAlpha.to
end

function PrologueVideoUI:GetPreloadAssetPaths()
	return
end

function PrologueVideoUI:GetOpenPreloadAssetPaths(userData)
	return
end

function PrologueVideoUI:OnOpen(userData)
	self.BtnBack:SetActive(false)

	self.currentIndex = 1
	self.paths = userData[1]
	self.index = userData[2]
	self.mediaTextTab = userData[3]
	self.mediaSoundTab = userData[4]
	self.mediaVideoTab = {}
	self.loadCount = 0
	self.preload = 0
	self.loadIndex = 0
	self.medias = {}
	self.playSound = {}
	self.times = {}

	for i = 1, #self.paths do
		local path = self.paths[i][1]

		self.medias[i] = path
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

	self.Text:GetComponent("Text").text = ""

	EventDispatcher.Dispatch(EventID.StopBGM)
end

function PrologueVideoUI:OnClose(userData)
	if self.textTimer then
		self.textTimer:Stop()
	end

	self.textTimer = nil

	for i, v in pairs(self.times) do
		v:Stop()

		v = nil
	end

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

	for i, v in pairs(self.playSound) do
		if v > 0 then
			GameEntry.Sound:StopSound(v)

			v = 0
		end
	end

	EventDispatcher.Dispatch(EventID.PlayVideoEnd, self.index)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function PrologueVideoUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateClickBtnBack)
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.delegateClickBtnJump)
end

function PrologueVideoUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnBack)
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnJump)
end

function PrologueVideoUI:OnPause()
	return
end

function PrologueVideoUI:OnResume()
	return
end

function PrologueVideoUI:OnCover()
	return
end

function PrologueVideoUI:OnReveal()
	return
end

function PrologueVideoUI:OnRefocus(userData)
	return
end

function PrologueVideoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.nextAvProVideo ~= nil and self.isWait == true and self.nextAvProVideo.isMovieLoadComplete == true then
		self.isWait = false

		self:LoadCompleteAndPlay()
	end
end

function PrologueVideoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PrologueVideoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PrologueVideoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PrologueVideoUI:OnDestroy()
	return
end

function PrologueVideoUI:OnBtnBack()
	UIModule.Close(Constant.UIControllerName.PrologueVideoUI)
end

function PrologueVideoUI:OnPlayMovieLoad(data)
	self.preload = self.preload + 1

	if self.preload == self.startLoad then
		self.currentIndex = 1

		self:PlayerVideo()
		self.BtnBack:SetActive(true)
	end
end

function PrologueVideoUI:OnBtnJump()
	if self.currentAvProVideo then
		self.currentAvProVideo:Pause()

		self.currentIndex = self.currentIndex + 1

		if self.currentIndex <= #self.medias then
			self:PlayerVideo()
		else
			self:OnBtnBack()
		end
	end
end

function PrologueVideoUI:OnPlayStart(data)
	if self.waitCloseAvProVideo ~= nil then
		self.waitCloseAvProVideo:CloseVideo()
	end
end

function PrologueVideoUI:OnPlayMovieComplete(data)
	self.currentAvProVideo:Pause()

	self.currentIndex = data.index + 1

	if self.currentIndex <= #self.medias then
		self:PlayerVideo()
	else
		self:OnBtnBack()
	end
end

function PrologueVideoUI:PlayerVideo()
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

function PrologueVideoUI:LoadCompleteAndPlay()
	if self.currentAvProVideo then
		self.waitCloseAvProVideo = self.currentAvProVideo
	end

	self.currentAvProVideo = self.nextAvProVideo

	local isLoop = self.paths[self.currentIndex][2]

	self.BtnJump:SetActive(isLoop)
	self.currentAvProVideo:PlayVideo(isLoop)
	self:ShowText()
	self:PlaySound()
end

function PrologueVideoUI:ShowText()
	if self.mediaTextTab then
		for i = 1, #self.mediaTextTab do
			local textTab = self.mediaTextTab[i]
			local delay = textTab[1]
			local str = textTab[2]
			local openIndex = textTab[3]
			local closeIndex = textTab[4]

			if closeIndex == self.currentIndex then
				self:CloseText()
			end

			if openIndex == self.currentIndex then
				self:OpenText(delay, str)
			end
		end
	end
end

function PrologueVideoUI:OpenText(delay, str)
	if self.textTimer then
		self.textTimer:Stop()

		self.textTimer = nil
	end

	self.textTimer = Timer.New(function()
		if not LuaCodeInterface.GameObjIsDestroy(self.Text) then
			self.Text:GetComponent("Text").text = str

			self.Text:SetActive(true)
			LuaCodeInterface.TweenAlpha(self.Text, self.tweenDuration, self.tweenForm, self.tweenTo, nil)
		end
	end, delay)

	self.textTimer:Start()
end

function PrologueVideoUI:CloseText()
	LuaCodeInterface.TweenAlpha(self.Text, self.tweenDuration, self.tweenTo, self.tweenForm, function()
		self.Text:GetComponent("Text").text = ""
	end)
end

function PrologueVideoUI:PlaySound()
	if self.mediaSoundTab then
		for i = 1, #self.mediaSoundTab do
			local soundTab = self.mediaSoundTab[i]
			local soundId = soundTab[1]
			local startIndex = soundTab[2]
			local closeIndex = soundTab[3]
			local delayTime = soundTab[4]

			if startIndex == self.currentIndex then
				local timer = Timer.New(function()
					local playSound = GameEntry.Sound:PlaySound(soundId, Constant.SoundGroup.UI)

					self.playSound[soundId] = playSound
				end, delayTime)

				timer:Start()
				table.insert(self.times, timer)
			end

			if closeIndex == self.currentIndex then
				local sound = self.playSound[soundId]

				if sound ~= nil and sound > 0 then
					local cfgSound = CfgSoundTable[soundId]

					GameEntry.Sound:StopSound(sound, cfgSound.FadeOutSeconds)

					self.playSound[soundId] = 0
				end
			end
		end
	end
end

function PrologueVideoUI:OnLoadErrorJump()
	self:OnBtnBack()
end

return PrologueVideoUI
