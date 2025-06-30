-- chunkname: @IQIGame\\UI\\AVPro\\AVProView.lua

AVProView = {
	isCurtain = false
}

function AVProView.New()
	local view = Clone(AVProView)

	function view.delegateSpineCurtainFall(trackEntry)
		view:OnSpineCurtainFall()
	end

	function view.delegateSpineCurtainUp(trackEntry)
		view:OnSpineCurtainUp()
	end

	function view.delegateSpineCurtainEndDown(trackEntry)
		view:OnSpineCurtainEndDown()
	end

	function view.delegateSpineCurtainEndUp(trackEntry)
		view:OnSpineCurtainEndUp()
	end

	function view.delegationEvent(m, y, code)
		view:MediaEvent(m, y, code)
	end

	return view
end

function AVProView:GetSpineAction(name)
	local small = IQIGame.Onigao.Game.Device.IsSmallScreen()

	if small then
		return name
	else
		return name .. "_1"
	end
end

function AVProView:Show(rootView, curtainParentNode, videoParentNode, curtainPath, url)
	self.isCurtain = true

	if not string.find(url, "http") then
		url = GameEntry.ProjectSetting.BuildInfo.MediaUrl .. url
	end

	self.playing = false
	self.url = url
	self.rootView = rootView
	self.curtainParentNode = curtainParentNode
	self.videoParentNode = videoParentNode
	self.curtainPath = curtainPath

	AssetUtil.LoadAsset(self, "Assets/03_Prefabs" .. self.curtainPath, self.OnLoadCurtainSucceed, self.OnLoadFailed)
end

function AVProView:OnLoadCurtainSucceed(assetName, asset, duration, userData)
	self.curtain = UnityEngine.Object.Instantiate(asset)
	self.curtain.transform.localPosition = Vector3(10000, 10000, 10000)

	local timer = FrameTimer.New(function()
		self.curtain.transform.localPosition = Vector3.zero
	end, 3)

	timer:Start()
	self.curtain.transform:SetParent(self.curtainParentNode.transform, false)

	self.curtain.transform.localScale = Vector3(100, 100, 100)
	self.curtainSpineObj = self.curtain.transform:GetChild(0)
	self.curtainSpineObj.gameObject:GetComponentInChildren(typeof(UnityEngine.MeshRenderer)).sortingOrder = self.rootView:GetComponent("Canvas").sortingOrder + 10
	self.skeletonAnimation = self.curtainSpineObj:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, self:GetSpineAction("Start_FallDown"), false)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineCurtainFall

	if self.loadCurtainComplete ~= nil then
		self:loadCurtainComplete()
	end
end

function AVProView:OnLoadFailed(assetName, asset, duration, userData)
	logError("加载失败 " .. assetName)
end

function AVProView:MediaEvent(m, type, code)
	if self.mediaPlayer == nil then
		return
	end

	if m ~= self.mediaPlayer.MediaPlayer then
		return
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.MetaDataReady == type and not self.playing then
		if self.loadComplete ~= nil then
			self:loadComplete(self.videoObj, self.mediaPlayer)
		end

		self:OnPlayMovieLoad()
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Started == type and not self.playing then
		self:OnPlayStart()
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying == type and self.playing then
		self.mediaPlayer:Pause()
		self:OnPlayMovieComplete()

		if self.playComplete ~= nil then
			self:playComplete()
		end
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error == type then
		NoticeModule.ShowNoticeNoCallback(21040087)
		self:Shutdown()

		if self.videoError ~= nil then
			self:videoError()
		end
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedBuffering == type and self.finishedBuffering ~= nil then
		self:finishedBuffering()
	end
end

function AVProView:OnPlayStart()
	self.playing = true
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineCurtainUp
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetAnimation(0, self:GetSpineAction("Start_Rise"), false)
end

function AVProView:OnPlayMovieComplete()
	self.playing = false
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineCurtainEndDown
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetAnimation(0, self:GetSpineAction("End_Down"), false)

	if self.playCurtainEndFall ~= nil then
		self.playCurtainEndFall()
	end

	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function AVProView:OnPlayMovieLoad()
	EventDispatcher.Dispatch(EventID.StopBGM)
	self.mediaPlayer:Play(false)
end

function AVProView:OnSpineCurtainFall()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineCurtainFall
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetAnimation(0, self:GetSpineAction("Start_FallDown_Loop"), false)
	AssetUtil.LoadAsset(self, AssetPath.Get(GlobalKey.UIPrefabPath, "Common/AVPro"), self.OnLoadSucceed, self.OnLoadFailed)
end

function AVProView:OnLoadSucceed(assetName, asset, duration, userData)
	self.videoObj = UnityEngine.Object.Instantiate(asset)

	self.videoObj.transform:SetParent(self.videoParentNode.transform, false)

	self.mediaPlayer = self.videoObj.gameObject:GetComponentInChildren(typeof(MediaMB))

	self.mediaPlayer:AddListener(self.delegationEvent)

	self.mediaPlayer.Volume = SettingModule.currentSoundVolume

	local isError = self.mediaPlayer:OpenVideoFromHttpUrl(self.url, false)

	if isError == false then
		NoticeModule.ShowNoticeNoCallback(21040087)
		self:Shutdown()

		if self.videoError ~= nil then
			self:videoError()
		end
	end
end

function AVProView:OnSpineCurtainUp()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineCurtainUp
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetAnimation(0, self:GetSpineAction("Play_Loop"), true)

	if self.playCurtainEnterLoop ~= nil then
		self.playCurtainEnterLoop()
	end
end

function AVProView:OnSpineCurtainEndUp()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineCurtainEndUp

	self:Shutdown()

	if self.playCurtainEndComplete ~= nil then
		self:playCurtainEndComplete()
	end
end

function AVProView:OnSpineCurtainEndDown()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineCurtainEndDown
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetAnimation(0, self:GetSpineAction("End_Up"), false)
	self.videoObj:SetActive(false)

	if self.playCurtainEndDownOver ~= nil then
		self:playCurtainEndDownOver()
	end

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineCurtainEndUp
end

function AVProView:Shutdown()
	AssetUtil.UnloadAsset(self)

	if self.mediaPlayer then
		self.mediaPlayer:RemoveListener(self.delegationEvent)
		self.mediaPlayer:CloseVideo()

		self.mediaPlayer = nil
	end

	if self.videoObj then
		UnityEngine.GameObject.DestroyImmediate(self.videoObj)

		self.videoObj = nil
	end

	if self.curtain then
		UnityEngine.GameObject.DestroyImmediate(self.curtain)

		self.curtain = nil
	end

	self.skeletonAnimation = nil
	self.curtainSpineObj = nil
	self.curtainParentNode = nil
	self.videoParentNode = nil
	self.curtainPath = nil
	self.url = nil
	self.rootView = nil
	self.isCurtain = false
	self.playing = false
end

function AVProView:CloseVideo()
	if not self.playing then
		return
	end

	self.mediaPlayer:Pause()
	self:OnPlayMovieComplete()
end
