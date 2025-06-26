-- chunkname: @IQIGame\\UI\\ShowCGUI.lua

local ShowCGUI = {}

ShowCGUI = Base:Extend("ShowCGUI", "IQIGame.Onigao.UI.ShowCGUI", ShowCGUI)

function ShowCGUI:OnInit()
	function self.DelegateOnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
		self:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	end

	function self.DelegateCloseBtn()
		self:OnCloseBtnClick()
	end

	function self.DelegateCheckBtn()
		self:OnCheckBtnCilck()
	end
end

function ShowCGUI:GetPreloadAssetPaths()
	return nil
end

function ShowCGUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ShowCGUI:IsManualShowOnOpen(userData)
	return false
end

function ShowCGUI:GetBGM(userData)
	return nil
end

function ShowCGUI:OnOpen(args)
	self.ShowType = args[1]
	self.CfgData = args[2]

	self.MaskParent:SetActive(false)

	if self.ShowType == UserInfoModule.ShowType.CG then
		self:ShowVideoInitInfo()
	elseif self.ShowType == UserInfoModule.ShowType.IMG then
		self:ShowImgInitInfo()
	end
end

function ShowCGUI:OnClose(userData)
	if self.ShowType == UserInfoModule.ShowType.CG then
		self:CloseVideoInfo()
	elseif self.ShowType == UserInfoModule.ShowType.IMG then
		self:CloseImgInitInfo()
	end
end

function ShowCGUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.CheckBtn:GetComponent("Button").onClick:AddListener(self.DelegateCheckBtn)
end

function ShowCGUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.CheckBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCheckBtn)
end

function ShowCGUI:OnPause()
	return
end

function ShowCGUI:OnResume()
	return
end

function ShowCGUI:OnCover()
	return
end

function ShowCGUI:OnReveal()
	return
end

function ShowCGUI:OnRefocus(userData)
	return
end

function ShowCGUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ShowCGUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ShowCGUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ShowCGUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ShowCGUI:OnDestroy()
	return
end

function ShowCGUI:ShowVideoInitInfo()
	self.CGParent:SetActive(true)

	local mediaPlayer = self.MediaPlayer1:GetComponent("MediaPlayer")

	mediaPlayer.Events:AddListener(self.DelegateOnMediaPlayerEvent)
	mediaPlayer:OpenVideoFromFile(RenderHeads.Media.AVProVideo.MediaPlayer.FileLocation.RelativeToStreamingAssetsFolder, ShowCGUIApi:GetVideoPath(), false)

	local mediaPlayer = self.MediaPlayer1:GetComponent("MediaPlayer")

	mediaPlayer:Play()
end

function ShowCGUI:CloseVideoInfo()
	self.CGParent:SetActive(false)

	local mediaPlayer = self.MediaPlayer1:GetComponent("MediaPlayer")

	mediaPlayer.Events:RemoveListener(self.DelegateOnMediaPlayerEvent)
	mediaPlayer:CloseVideo()
end

function ShowCGUI:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
		self.PlayVideoError = true
	end
end

function ShowCGUI:ShowImgInitInfo()
	self.IllustrationParent:SetActive(true)

	local path = UIGlobalApi.GetImagePath(self.CfgData.Picture)

	self:LoadImg(path, self.IllustrationImg)
end

function ShowCGUI:CloseImgInitInfo()
	self.IllustrationParent:SetActive(false)
end

function ShowCGUI:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"), self.LoadImageSucess, nil, obj:GetComponent("Image"))
end

function ShowCGUI:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function ShowCGUI:OnCloseBtnClick()
	UIModule.CloseSelf(self)
end

function ShowCGUI:OnCheckBtnCilck()
	self.MaskParent:SetActive(not self.MaskParent.activeSelf)
end

return ShowCGUI
