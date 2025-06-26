-- chunkname: @IQIGame\\UI\\AVPro\\AVProVideoView.lua

AVProVideoView = {}

function AVProVideoView.New()
	local view = Clone(AVProVideoView)

	view.defaultAVPath = AssetPath.Get(GlobalKey.UIPrefabPath, "Common/AVPro")

	function view.delegateOnPlayMovieComplete()
		view:OnPlayMovieComplete()
	end

	function view.delegateOnPlayMovieLoad(x, y)
		view:OnPlayMovieLoad(x, y)
	end

	function view.delegationEvent(m, y, code)
		view:MediaEvent(m, y, code)
	end

	return view
end

function AVProVideoView:LoadAVPro(videoNode, index, mediaData)
	self.videoParentNode = videoNode
	self.index = index
	self.mediaData = mediaData

	AssetUtil.LoadAsset(self, self.defaultAVPath, self.OnLoadSucceed, self.OnLoadFailed)
end

function AVProVideoView:LoadVideo(url)
	self.url = url

	self.mediaPlayer:OpenVideoFromFile(self.url, false)

	self.isMovieLoadComplete = false
end

function AVProVideoView:OnLoadSucceed(assetName, asset, duration, userData)
	local obj = UnityEngine.Object.Instantiate(asset)

	obj.transform:SetParent(self.videoParentNode.transform, false)

	local mediaPlayer = obj.gameObject:GetComponentInChildren(typeof(MediaMB))

	mediaPlayer:RemoveListener(self.delegationEvent)
	mediaPlayer:AddListener(self.delegationEvent)

	mediaPlayer.Volume = SettingModule.currentSoundVolume
	self.mediaPlayer = mediaPlayer
	self.videoNode = obj

	self.videoNode:SetActive(true)
	self.videoParentNode:SetActive(true)
	self:LoadVideo(self.mediaData)

	if self.loadAVProComplete ~= nil then
		self.loadAVProComplete(self)
	end
end

function AVProVideoView:OnLoadFailed(assetName, asset, duration, userData)
	logError("加载失败 " .. assetName)
end

function AVProVideoView:UnloadAsset()
	AssetUtil.UnloadAsset(self)
end

function AVProVideoView:MediaEvent(m, type, code)
	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.MetaDataReady == type then
		self:OnPlayMovieLoad(self.videoNode, self.mediaPlayer)

		if self.loadComplete ~= nil then
			self:loadComplete(self)
		end
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Started == type and self.playStarted ~= nil then
		self:playStarted(self)
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying == type then
		self.mediaPlayer:Pause()
		self:OnPlayMovieComplete()

		if self.playComplete ~= nil then
			self:playComplete(self)
		end
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error == type then
		self.videoNode.gameObject:SetActive(false)

		if self.loadErrorJump then
			self.loadErrorJump()
		end

		NoticeModule.ShowNoticeNoCallback(21040087)
	end

	if RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedBuffering == type and self.finishedBuffering ~= nil then
		self:finishedBuffering()
	end
end

function AVProVideoView:OnPlayMovieLoad(gameObj, mediaPlayer)
	self.videoNode:SetActive(false)
	self:SetVideoSeekSlider(0)

	self.isMovieLoadComplete = true
end

function AVProVideoView:OnPlayMovieComplete()
	return
end

function AVProVideoView:PlayVideo(isLoop)
	if self.videoNode.transform.parent ~= self.videoParentNode.transform then
		self.videoNode.transform:SetParent(self.videoParentNode.transform, false)
	end

	self.videoNode:SetActive(true)
	self.mediaPlayer:Play(isLoop)
end

function AVProVideoView:SetVideoSeekSlider(value)
	if self.mediaPlayer then
		self.mediaPlayer:Seek(value)
	end
end

function AVProVideoView:Pause()
	if self.mediaPlayer then
		self.mediaPlayer:Pause()
	end
end

function AVProVideoView:CloseVideo()
	if self.mediaPlayer then
		self.mediaPlayer:RemoveListener(self.delegationEvent)
		self.mediaPlayer:CloseVideo()
	end

	if self.videoNode then
		if self.videoNode.transform.parent then
			self.videoNode.transform:SetParent(nil)
		end

		self.videoNode:SetActive(false)
		UnityEngine.Object.Destroy(self.videoNode)
	end

	self.mediaPlayer = nil
	self.videoNode = nil
end

function AVProVideoView:DisPose()
	self.isMovieLoadComplete = false

	if self.mediaPlayer and not LuaCodeInterface.GameObjIsDestroy(self.mediaPlayer) then
		self.mediaPlayer:RemoveListener(self.delegationEvent)
		self.mediaPlayer:CloseVideo()

		self.mediaPlayer = nil
	end

	if self.videoNode and not LuaCodeInterface.GameObjIsDestroy(self.videoNode) then
		self.videoNode:SetActive(false)
		UnityEngine.Object.Destroy(self.videoNode)

		self.videoNode = nil
	end

	self:UnloadAsset()
end
